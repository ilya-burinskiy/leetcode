def minimum_total(triangle)
  for i in (0...triangle.length - 1)
    tmp = triangle[i + 1].dup
    triangle[i + 1][0] += triangle[i][0]
    triangle[i + 1][1] += triangle[i][0]

    for j in (1...triangle[i].length)
      triangle[i + 1][j] = [triangle[i + 1][j], tmp[j] + triangle[i][j]].min
      triangle[i + 1][j + 1] = triangle[i][j] + tmp[j + 1]
    end
  end

  triangle.last.min
end
