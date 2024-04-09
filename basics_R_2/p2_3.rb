arr = [0, 1]
i = 0
while i <= 100 do
  arr.push(i)
  i = arr[-2] + arr[-1]
end
arr.delete_at(0)
arr.delete_at(0)
puts arr
