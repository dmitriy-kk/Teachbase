puts "Введите три стороны треугольника"
print "a = "
a = gets.chomp.to_i
print "b = "
b = gets.chomp.to_i
print "c = "
c = gets.chomp.to_i

if a == b && b == c
  puts "Треугольник равносторонний"
elsif a == b || b == c
  puts "Треугольник равнобедренный"
else
  puts "Треугольник другой"
end
