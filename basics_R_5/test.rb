k1 = Station.new("k1")
k2 = Station.new("k2")
e1 = Station.new("e1")
e2 = Station.new("e2")
puts "Список станций #{Station.all}"
puts "Количество станций #{Station.instances}"

r1 = Route.new(k1, e1)
r2 = Route.new(k2, e2)
puts "Количествок маршрутов #{Route.instances}"



t1 = PassengerTrain.new(1)
t2 = PassengerTrain.new(2)
c1 = CargoTrain.new(3)




#puts "Саисок поездов #{Train.trains}"
puts "Количество #{Train.instances}"

r1.add_intermediate_station(k2)
r1.add_intermediate_station(e2)
puts "Список станций #{r1.list_station.each{|i| puts i.name}}"
r1.delete_station(e2)
puts "Список станций #{r1.list_station}"

t1.add_route(r1)
t2.add_route(r1)
c1.add_route(r1)
puts "маршрут поезда t1: #{t1.route}"
puts "маршрут поезда t2: #{t2.route}"
puts "маршрут поезда c1: #{c1.route}"
k1.add_train(t1)
k1.add_train(t2)
k1.add_train(c1)

t1.add_wagon(PassengerWagon.new)
t1.add_wagon(PassengerWagon.new)
t1.add_wagon(PassengerWagon.new)
c1.add_wagon(CargoWagon.new)
puts "К поезду t1 зацеплено: #{t1.wagons}"
puts "К поезду с1 зацеплено: #{c1.wagons}"


t1.delete_wagon
puts "К поезду t1 зацеплено: #{t1.wagons}"

puts "поезд c1 на станции #{c1.location_station.name}"
c1.station_up
puts "поезд c1 переместился на станцию #{c1.location_station.name}"
puts "поезд t2 на станции #{t2.location_station.name}"
t2.station_down
puts "поезд t2 переместился на станцию #{t2.location_station.name}"

print "список поездов на станции k1: " 
k1.trains.each {|t| puts t.number}
print "список поездов на станции e1: " 
e1.trains.each {|t| puts t.number}
print "список поездов на станции k2: " 
k2.trains.each {|t| puts t.number}

puts "Количество созданных пасажирских вагонов: #{PassengerWagon.instances}; грузовых: #{CargoWagon.instances}"
puts "Количество созданных пасажирских поездов: #{PassengerTrain.instances}; грузовых: #{CargoTrain.instances}"
puts "Количество созданных маршрутов: #{Route.instances}"
puts "Количество созданных станций: #{Station.instances}"
puts "Количество созданных поездов: #{Train.instances}"
puts "результат #{Train.find}"
