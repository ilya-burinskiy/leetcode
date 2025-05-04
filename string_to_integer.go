package main

/*

*/
func myAtoi(s string) int {
	var currState int
	var i int
	const (
		initState = 0
		readBlank = 1

	)
	for i < len(s) {
		switch currState {
		// init state
		case initState:
			switch s[i] {
			case ' ', '\t', '\r':
			case '+':
			case '-':
			}
		// read blank chars
		case 1:
		default:
		}
	}

	return 0
}

func main() {
}
