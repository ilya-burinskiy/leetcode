def is_match(s, p)
  ast = Parser.parse(p)
  builder = NFABuilder.new
  nfa = builder.call(ast)
  nfa.accept(s)
end

# Terminal symbols
ALNUM  = :alnum
DOT    = :dot
CONCAT = :concat
KLEENE = :kleene
UNION  = :union
LBRACE = :lbrace
RBRACE = :rbrace
# Non-terminal symbols
R4  = :R4
R4_ = :R4_
R3  = :R3
R3_ = :R3_
R2  = :R2
R2_ = :R2_
R1  = :R1
# Special symbols
INPUT_ENDMARKER = :input_endmarker # $

class Token
  attr_accessor :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end
end

module Lexer
  class << self
    def tokenize(input)
      Enumerator.new do |yielder|
        input_enumerator = input.each_char
        yield_concat = false

        i = 0
        while i < input.length
          if yield_concat
            yielder << Token.new(CONCAT, '·')
            yield_concat = false
          else
            curr_sym = input_enumerator.next
            next_sym = input_enumerator.peek rescue ''
            token = case curr_sym
                    when ('a'..'z'), ('A'..'Z'), ('0'..'9')
                      yield_concat = yield_concat?(next_sym)
                      Token.new(ALNUM, curr_sym)
                    when '.'
                      yield_concat = yield_concat?(next_sym)
                      Token.new(DOT, '.')
                    when '*'
                      yield_concat = yield_concat?(next_sym)
                      Token.new(KLEENE, '*')
                    when '|' then Token.new(UNION, '|')
                    when '(' then Token.new(LBRACE, '(')
                    when ')'
                      yield_concat = yield_concat?(next_sym)
                      Token.new(RBRACE, ')')
                    else nil
                    end
            i += 1
            yielder << token
          end
        end

        while true
          yielder << Token.new(INPUT_ENDMARKER, '$')
        end
      end
    end

    private

    def yield_concat?(sym)
      ('a'..'z').include?(sym) || ('A'..'Z').include?(sym) ||
      ('0'..'9').include?(sym) || sym == '(' || sym == '.'
    end
  end
end

class Sym
  attr_reader :val

  def initialize(val)
    @val = val
  end
end

class AnySym; end

class Union
  attr_reader :lhs, :rhs

  def initialize(lhs, rhs)
    @lhs = lhs
    @rhs = rhs
  end
end

class Concat
  attr_reader :lhs, :rhs

  def initialize(lhs, rhs)
    @lhs = lhs
    @rhs = rhs
  end
end

class Kleene
  attr_reader :node

  def initialize(node)
    @node = node
  end
end

module Parser
  class << self
    def parse(input)
      token_gen = Lexer.tokenize(input)
      stack = [INPUT_ENDMARKER, R4]
      symbol = stack.last
      operands_stack = []
      operators_stack = []

      while symbol != INPUT_ENDMARKER do
        current_token = token_gen.peek

        if symbol == current_token.name
          if symbol == ALNUM
            operands_stack << Sym.new(current_token.value)
          elsif symbol == DOT
            operands_stack << AnySym.new
          else
            operators_stack << symbol
          end

          stack.pop
          token_gen.next
        elsif [ALNUM, DOT, KLEENE, UNION, LBRACE, RBRACE, CONCAT].include?(symbol)
          break nil
        else
          production = predict_table(symbol, current_token.name)

          case stack.pop
          when R2_
            if operators_stack.last == KLEENE
              if !operands_stack.last.is_a?(Kleene)
                operand = operands_stack.pop
                operators_stack.pop
                operands_stack << Kleene.new(operand)
              else
                operators_stack.pop
              end
            end
          when R3_
            if operators_stack.last == CONCAT
              rhs = operands_stack.pop
              lhs = operands_stack.pop
              operators_stack.pop
              operands_stack << Concat.new(lhs, rhs)
            end
          when R4_
            if operators_stack.last == UNION
              rhs = operands_stack.pop
              lhs = operands_stack.pop
              operators_stack.pop
              operands_stack << Union.new(lhs, rhs)
            end
          end

          production.reverse.each { |s| stack.push(s) }
        end

        symbol = stack.last
      end

      operands_stack.pop
    end

    private

    def predict_table(grammar_symbol, current_token_name)
      case [grammar_symbol, current_token_name]
      in [R4, LBRACE] | [R4, ALNUM] | [R4, DOT] then [R3, R4_]
      in [R4_, UNION] then [UNION, R3, R4_]
      in [R4_, RBRACE] | [R4_, INPUT_ENDMARKER] then []
      in [R3, LBRACE] | [R3, ALNUM] | [R3, DOT] then [R2, R3_]
      in [R3_, CONCAT] then [CONCAT, R2, R3_]
      in [R3_, UNION] | [R3_, RBRACE] | [R3_, INPUT_ENDMARKER] then []
      in [R2, LBRACE] | [R2, ALNUM] | [R2, DOT] then [R1, R2_]
      in [R2_, KLEENE] then [KLEENE, R2_]
      in [R2_, UNION] | [R2_, RBRACE] | [R2_, CONCAT] | [R2_, INPUT_ENDMARKER] then []
      in [R1, LBRACE] then [LBRACE, R4, RBRACE]
      in [R1, ALNUM] then [ALNUM]
      in [R1, DOT] then [DOT]
      else nil
      end
    end
  end
end


class Nfa
  EPS_SYMBOL = '\x00'

  attr_reader :init_state, :accept_states
  attr_writer :accept_states

  def initialize(init_state, accept_states = Set[])
    @transition_table = Hash.new { |h, k| h[k] = Set[] }
    @init_state = init_state
    @accept_states = accept_states
  end

  def get(state, char)
    @transition_table[[state, char]]
  end

  def each_transition(&block)
    @transition_table.each do |k, dsts|
      block.call(k[0], k[1], dsts)
    end
  end

  def add_transition(dst, src, char)
    @transition_table[[src, char]].add(dst)
  end

  def accept(input)
    s = eps_closure(@init_state)
    input.each_char do |char|
      m = Set[]
      s.each do |state|
        m = m + move(state, char)
      end

      s = Set[]
      m.each do |state|
        s = s + eps_closure(state)
      end
    end

    (s & @accept_states).length > 0
  end

  private

  def eps_closure(s)
    stack = [s]
    result = Set[s]
    until stack.empty?
      state = stack.pop
      @transition_table[[state, EPS_SYMBOL]].each do |u|
        unless result.include?(u)
          result.add(u)
          stack.push(u)
        end
      end
    end

    result
  end

  def move(state, symbol)
    @transition_table[[state, symbol]]
  end
end

class NFABuilder
  def initialize
    @stack = []
    @state = 0
  end

  def call(ast)
    postorder_traverse(ast)
    @stack.pop
  end

  private

  def on_sym_exit(sym)
    init_state = next_state
    accept_state = next_state
    nfa = Nfa.new(init_state, Set[accept_state])
    nfa.add_transition(accept_state, init_state, sym.val)
    @stack << nfa
  end

  def on_any_sym_exit(_anysym)
    init_state = next_state
    accept_state = next_state
    nfa = Nfa.new(init_state, Set[accept_state])
    [*('a'..'z'), *('A'..'Z'), *('0'..'9')].each do |char|
      nfa.add_transition(accept_state, init_state, char)
    end
    @stack << nfa
  end

  def on_kleene_exit(kleene)
    nfa = @stack.pop
    init_state = next_state
    accept_state = next_state
    kleene_nfa = Nfa.new(init_state, Set[accept_state])
    nfa.each_transition do |src, char, dsts|
      dsts.each do |dst|
        kleene_nfa.add_transition(dst, src, char)
      end
    end
    kleene_nfa.add_transition(nfa.init_state, init_state, Nfa::EPS_SYMBOL)
    kleene_nfa.add_transition(accept_state, init_state, Nfa::EPS_SYMBOL)
    kleene_nfa.add_transition(nfa.init_state, nfa.accept_states.first, Nfa::EPS_SYMBOL)
    kleene_nfa.add_transition(accept_state, nfa.accept_states.first, Nfa::EPS_SYMBOL)
    @stack << kleene_nfa
  end

  def on_concat_exit(concat)
    second_nfa = @stack.pop
    first_nfa = @stack.pop
    concat_nfa = Nfa.new(first_nfa.init_state, second_nfa.accept_states)
    first_nfa.each_transition do |src, char, dsts|
      dsts.each do |dst|
        concat_nfa.add_transition(dst, src, char)
      end
    end
    second_nfa.each_transition do |src, char, dsts|
      if src == second_nfa.init_state
        src = first_nfa.accept_states.first
      end
      dsts.each do |dst|
        concat_nfa.add_transition(dst, src, char)
      end
    end
    @stack << concat_nfa
  end

  def on_union_exit(union)
    second_nfa = @stack.pop
    first_nfa = @stack.pop
    init_state = next_state
    accept_state = next_state
    union_nfa = Nfa.new(init_state, Set[accept_state])
    first_nfa.each_transition do |src, char, dsts|
      dsts.each do |dst|
        union_nfa.add_transition(dst, src, char)
      end
    end
    second_nfa.each_transition do |src, char, dsts|
      dsts.each do |dst|
        union_nfa.add_transition(dst, src, char)
      end
    end
    union_nfa.add_transition(first_nfa.init_state, init_state, Nfa::EPS_SYMBOL)
    union_nfa.add_transition(second_nfa.init_state, init_state, Nfa::EPS_SYMBOL)
    union_nfa.add_transition(accept_state, first_nfa.accept_states.first, Nfa::EPS_SYMBOL)
    union_nfa.add_transition(accept_state, second_nfa.accept_states.first, Nfa::EPS_SYMBOL)
    @stack << union_nfa
  end

  def postorder_traverse(node)
    if node.is_a?(Union)
      postorder_traverse(node.lhs)
      postorder_traverse(node.rhs)
      on_union_exit(node)
    elsif node.is_a?(Concat)
      postorder_traverse(node.lhs)
      postorder_traverse(node.rhs)
      on_concat_exit(node)
    elsif node.is_a?(Kleene)
      postorder_traverse(node.node)
      on_kleene_exit(node)
    elsif node.is_a?(Sym)
      on_sym_exit(node)
    elsif node.is_a?(AnySym)
      on_any_sym_exit(node)
    end
  end

  def next_state()
    tmp = @state
    @state += 1
    tmp
  end
end
