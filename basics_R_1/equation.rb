puts "Введите коэфиценты"
print "a = "
a = gets.chomp.to_i
print "b = "
b = gets.chomp.to_i
print "c = "
c = gets.chomp.to_i

d = b ** 2 - 4 * a * c


if d == 0
  puts %( 
          Дискрименант уравнения D = 0 
          Корень уравнения X1 = X2 = #{- b / (2 * a)}
        )
elsif d > 0
  c2 = Math.sqrt(d)
  puts %( 
          Дискрименант уравнения D = #{d} 
          Корень уравнения X1 = #{(- b + c2) / (2 * a)}
          Корень уравнения X2 = #{(- b - c2) / (2 * a)}
        )
else
  puts %( 
          Дискрименант уравнения D = #{d} меньше нуля
          у уровнения корней нет
        )
end