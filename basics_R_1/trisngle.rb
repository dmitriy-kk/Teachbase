puts "Введите три стороны треугольника"
print "a = "
a = gets.chomp.to_i
print "b = "
b = gets.chomp.to_i
print "c = "
c = gets.chomp.to_i

if a > b && a > c && a**2 == b ** 2 + c ** 2
  puts "Треугольник прямоугольный"
elsif b > a && b > c && a**2 == b ** 2 + c ** 2
  puts "Треугольник прямоугольный"
elsif c > b && c > a && a**2 == b ** 2 + c ** 2
      puts "Треугольник прямоугольный"
elsif a == b && b == c
  puts "Треугольник равносторонний"
elsif a ==b || b == c
  puts "Треугольник равнобедренный"
else
  puts "Треугольник разносторонний"
end
