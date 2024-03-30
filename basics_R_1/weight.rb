puts "Как вас зовут"
name = gets.chomp

puts "Напишите ваш рост"
height = gets.chomp.to_i

weight = ( height - 110 ) * 1.15

if weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "Ваш идеальный вес #{weight} кг."
end



