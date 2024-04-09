vowels_hash = {}
arr = ('а'..'я').to_a
arr.insert(6, "ё")

str = "аеёиоуыэюя"
str.each_char do |i|
   num = arr.index(i) + 1
   vowels_hash[i.to_sym] = num
end

print vowels_hash
