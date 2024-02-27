def longest_common_prefix(strs)
  strs = strs.map { |str| str.split('').each_with_index.to_a }
  common_prefix = strs[0]
  strs[1..].reduce(common_prefix) do |common_prefix, str|
    common_prefix.take_while { |char, idx| char == str[idx]&.at(0) }
  end.map { |char, _| char }.join('')
end
