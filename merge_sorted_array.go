package main

func merge(as []int, n int, bs []int, m int) {
    if m == 0 {
		return
	}

	if n == 0 {
		for i := 0; i < m; i++ {
			as[i] = bs[i]
		}
		return
	}

	i := n - 1
	j := m - 1
	k := n + m - 1
	for i >= 0 && j >=0  {
		if bs[j] >= as[i] {
			as[k] = bs[j]
			j--
		} else {
			as[i], as[k] = as[k], as[i]
			i--
		}
		k--
	}

	if i == -1 {
		for j >= 0 {
			as[k] = bs[j]
			j--
			k--
		}
	}
}
