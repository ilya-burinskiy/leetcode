package main

import (
	"fmt"
	"math"
	"errors"
)

var ErrOverflow = errors.New("integer overflow")

func myAtoi(s string) int {
	const (
		initState = iota
		readBlank
		readSign
		readNumber
		stop
	)
	var currState int
	var isNegative bool

	var i int
	digits := []uint8{}
Loop:
	for i < len(s) {
		switch currState {
		case initState:
			switch s[i] {
			case ' ':
				currState = readBlank
			case '+', '-':
				currState = readSign
			case '.':
				currState = stop
			default:
				currState = readNumber
			}
		case readBlank:
			if s[i] == ' ' {
				i++
			} else {
				currState = readSign
			}
		case readSign:
			if s[i] == '-' {
				isNegative = true
				i++
			} else if s[i] == '+' {
				i++
			}
			currState = readNumber
		case readNumber:
			switch s[i] {
			case '0':
				digits = append(digits, 0)
			case '1':
				digits = append(digits, 1)
			case '2':
				digits = append(digits, 2)
			case '3':
				digits = append(digits, 3)
			case '4':
				digits = append(digits, 4)
			case '5':
				digits = append(digits, 5)
			case '6':
				digits = append(digits, 6)
			case '7':
				digits = append(digits, 7)
			case '8':
				digits = append(digits, 8)
			case '9':
				digits = append(digits, 9)
			default:
				currState = stop
			}
			i++
		case stop:
			break Loop
		default:
			panic("unexpected state")
		}
	}

	var result int32
	for i := 0; i < len(digits); i++ {
		if isNegative {
			var err error
			result, err = AddT32(result, -int32(digits[i]))
			if err != nil {
				return math.MinInt32
			}

			if i == len(digits) - 1 {
				continue
			}

			result, err = MultT32(result, 10)
			if err != nil {
				return math.MinInt32
			}
		} else {
			var err error
			result, err = AddT32(result, int32(digits[i]))
			if err != nil {
				return math.MaxInt32
			}

			if i == len(digits) - 1 {
				continue
			}

			result, err = MultT32(result, 10)
			if err != nil {
				return math.MaxInt32
			}
		}
	}

	return int(int32(result))
}

func AddT32(x, y int32) (int32, error) {
	z := x + y
	if x > 0 && y > 0 && z <= 0 ||
		x < 0 && y < 0 && z >= 0 {

		return 0, ErrOverflow
	}

	return z, nil
}

func MultT32(x, y int32) (int32, error) {
	p := x * y
	if x != 0 && p / x != y {
		return 0, ErrOverflow
	}

	return p, nil
}

func main() {
	// fmt.Println(myAtoi("   -042"))
	// fmt.Println(myAtoi("9223372036854775808"))
	// fmt.Println(myAtoi("-91283472332"))
	// fmt.Println(myAtoi("-2147483648"))
	fmt.Println(myAtoi("        321"))
}
