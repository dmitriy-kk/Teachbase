purchases = {}
cost_produkt = {}
cost = []

puts %( 
        Заполните список покупок, 
        по завершению ввода в любом поле 
        напишите СТОП" 
        )
loop do
  print "Введите название товара: "
  name = gets.chomp.to_s.strip.capitalize.gsub(" ", "_")
  break if name == "Стоп"
  print "Ведите цену за еденицу товара: "
  price = gets.chomp.to_s.strip.capitalize.gsub(" ", "_")
  break if price == "Стоп"
  print "Введите кол-во купленного товара: "
  quantity = gets.chomp.to_s.strip.capitalize.gsub(" ", "_")
  break if quantity == "Стоп"

  list_price = {}
  list_price[price.to_f] = quantity.to_f
  purchases[name.to_sym] = list_price

end

purchases.each do |k, v|
  v.each do |k1, v1|
    c = k1 * v1
    cost << c
    cost_produkt[k] = c
  end
end

puts purchases
cost_produkt.each {|k, v| puts " #{k} стоимость товара: #{v} руб."}
puts "Итоговая стоимость покупок: #{cost.sum} руб."
