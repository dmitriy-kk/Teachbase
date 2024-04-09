puts "Ведите число (dd), месяц (mm) и год Вашего рождения (yyyy)"
print "Число = "
d = gets.chomp.to_i
print "Месяц = "
m = gets.chomp.to_i
print "Год = "
y = gets.chomp.to_i

days_year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if y % 4 == 0 && y % 100 != 0 || y % 400 == 0
  days_year[1] = 29
  puts "Вы родились в високосном году"
end

print "Порядковый номер дня в году - #{days_year.first(m - 1).sum + d}"
