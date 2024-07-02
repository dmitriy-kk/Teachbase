class Interface
  include Validate
  attr_accessor :trains, :stations, :routes
    
  def initialize
      @stations = {}
      @trains = {}
      @routes = {}
  end

  def start
    puts %(
          123. Выход
          1. Создать станцию
          2. Создать поезд
          3. Создать маршрут
          4. Добавить удалить станцию в маршрут
          5. Назначить маршрут поезду
          6. Добавить вагоны к поезду
          7. Отцепить вагоны от поезда
          8. Переместить поезд по маршруту вперед и назад
          9. Просмотр списка станций и списка поездов на станции
          10. Занять место или объем в вагоне 
          
      )
  

    loop do 
      puts "Введите номер команды: "
      choice = gets.to_i
      case choice
      when 123
        break
      when 1
        station_new
      when 2
        train_new
      when 3
        route_new
      when 4
        add_down_station_route
      when 5
        add_route
      when 6
        add_wagon              
      when 7
        delete_wagon
      when 8
        drive_station_up_down              
      when 9
        list_station_list_trins_at_station
      when 10
        take_seat
      end
    end
  end

#1
  def station_new
    begin
      puts "Введите название создоваемой станции"
      name = gets.chomp.capitalize.to_s.lstrip
      @stations[name] = Station.new(name)
      puts "Станция #{name} построена"
    rescue RuntimeError => e
      puts "#{e}"
      retry
    end
  end
#2
  def train_new
    begin
      puts "Введите номер поезда формате: три буквы или три цифры +'-'(может быть или не быть) + две буквы или цифры"
      number = gets.chomp.downcase.to_s
      puts "Введите тип поезда если Пассажиркий - 1, если грузовой - 2"
      type = gets.chomp.to_i
      if type == 1
          @trains[number] = PassengerTrain.new(number)
          puts "Построен пассажирский поезд: #{@trains[number].number}"
      elsif type == 2
          @trains[number] = CargoTrain.new(number)
          puts "Построен грузовой поезд: #{@trains[number].number}"
      else
          puts "Такого типа поездов не существует"
      end
    rescue RuntimeError => e
      puts "#{e}"
      retry
    end
  end
#3 
  def route_new
    begin
      puts "Введите название маршрута"
      name = gets.chomp.downcase.to_s
      puts "Введите начальную точку маршрута"
      station1 = gets.chomp.capitalize.to_s.lstrip
      first_station = @stations[station1]
      puts "Ввведите конечную точку маршрута"
      station2 = gets.chomp.capitalize.to_s.lstrip
      final_station = @stations[station2]
      @routes[name] = Route.new(first_station, final_station)
      puts "Мршрут #{name} создан!"
    rescue RuntimeError => e
      puts "#{e}"
      puts "Маршрут не создан!!! Прежде чем добавлять станцию в маршрут создайте её!!!"
    end
  end
#4
  def add_down_station_route
    puts "Введите название маршрута"
    name_route = gets.chomp.downcase.to_s
    puts "Введите название станции"
    name = gets.chomp.capitalize.to_s.lstrip
    puts "Для добавления станции нажмите - 1, удаления - 2"
    type = gets.chomp.to_i
    if @stations.include?(name)
      if type == 1
        @routes[name_route].add_intermediate_station(@stations[name])    
      elsif type == 2
        @routes[name_route].delete_station(@stations[name])
      else
        puts "Номер команды введен неверно"
      end
    else
      puts "Такой станции не существует, создайте станцию"
    end
  rescue StandardError
    puts "Название маршрута введено не верно!!!"
    puts "Список созданных маршрутов:" 
      self.routes.each{|k,v| puts v.number}
  end
#5
  def add_route
    puts "Введите название маршрута"
    name_route = gets.chomp.downcase.to_s
    puts "Введите номер поезда"
    number = gets.chomp.downcase.to_s
    @trains[number].add_route(@routes[name_route])
  rescue StandardError
    puts "При вводе названия маршрута или номера поезда допущена ошибка!!!"
    puts "Список созданных маршрутов:" 
      self.routes.each{|k,v| puts v.number}
    puts "Список созданных поездов:" 
      self.trins.each{|k,v| puts v.number}
  end
#6
  def add_wagon
    puts "Введите номер поезда"
    number = gets.chomp.downcase.to_s
    puts "Введите количество мест или объем вагона."
    capacity = gets.chomp.to_i
    if @trains[number].type == :passenger
      @trains[number].add_wagon(PassengerWagon.new(capacity))
      puts "К поезду #{number} прицеплено вагонов: #{@trains[number].wagons.count}"
    elsif @trains[number].type == :cargo
      @trains[number].add_wagon(CargoWagon.new(capacity))
      puts "К поезду #{number} прицеплено вагонов: #{@trains[number].wagons.count}"
    end
  rescue StandardError => e
    puts "Поезд не создан или допущена ошибка при вводе!!!"
    puts "Список созданных поездов:" 
      self.trains.each{|k,v| puts v.number}
  end

#7
  def delete_wagon
    puts "Введите номер поезда"
    number = gets.chomp.downcase.to_s
    @trains[number].delete_wagon
    puts "К поезду #{number} прицеплено #{@trains[number].wagons.count} вагонов"
  rescue StandardError
    puts "Поезд не создан или допущена ошибка при вводе!!!"
    puts "Список созданных поездов:"
      self.trains.each{|k,v| puts v.number}
  end
#8
  def drive_station_up_down
    puts "Введите номер поезда"
    number = gets.chomp.downcase.to_s
    puts %(
          123. Выход
          1. Переместить поезд на станцию вперед.
          2. Переместить на станцию назад.
      )
  
    loop do 
      puts "Введите номер команды: "
      choice = gets.to_i
      case choice
        when 123
          break
        when 1
          @trains[number].station_up
        when 2
          @trains[number].station_down
      end
    end
    puts "Поезд прибыл на станцию #{@trains[number].location_station.name}"
  rescue StandardError
    puts "Поезд не создан или допущена ошибка при вводе!!!"
    puts "Список созданных поездов:"
      self.trains.each{|k,v| puts v.number}
  end
#9
  def list_station_list_trins_at_station
    puts %(
          123. Выход
          1. Просмотр списка станций.
          2. Просмотр списка поездов на станции.
          3. Просотр списка вагонов поезда.
      )
  
    loop do 
      puts "Введите номер команды: "
      choice = gets.to_i
      case choice
      when 123
        break
      when 1
        puts "Список станций:"
        @stations.each { |k, v| puts v.name }
      when 2
        begin
          puts "Введите название станции"
          name = gets.chomp.capitalize.to_s.lstrip
          puts "Список поездов:"
          puts @stations[name].block_trains { |t| puts "Номер поезда: #{t.number}; тип: #{t.type}; количество вагонов: #{t.wagons.count}." }
        rescue StandardError
          puts "Станция не создавалась или допущена ошибка при вводе!!!"
        end
      when 3
        begin
          puts "Введите номер поезда"
          number = gets.chomp.downcase.to_s
          trains[number].block_wagons {|w| puts "Номер вагона #{trains[number].wagons.index(w) + 1}; тип #{w.type}; свободных мест: #{w.free_capacity}; занятых мест: #{w.used_capacity}."} if trains[number].type == :passenger
          trains[number].block_wagons {|w| puts "Номер вагона #{trains[number].wagons.index(w) + 1}; тип #{w.type}; свободный объём: #{w.free_capacity}; занятый объём: #{w.used_capacity}."} if trains[number].type == :cargo
        rescue StandardError
          puts "Поезд не создан или допущена ошибка при вводе!!!"
          puts "Список созданных поездов:"
          self.trains.each{|k,v| puts v.number}
        end
      end
    end
  end
#10
  def take_seat
    puts "Введите номер поезда."
    number = gets.chomp.downcase.to_s
    puts "Введите номер вагона"
    num = gets.chomp.to_i
    if trains[number].type == :passenger
      trains[number].wagons[num-1].boarding
      puts "Пассажир сел в вагон."
    elsif trains[number].type == :cargo
      puts "Введите объем загружаемого груза."
      volume = gets.chomp.to_i
      trains[number].wagons[num-1].loading(volume)
    end
  rescue StandardError
    puts "Поезд не создан или допущена ошибка при вводе!!!"
    puts "Список созданных поездов:"
    self.trains.each{|k,v| puts "номер поезда: #{v.number}; количество вагонов: #{v.wagons.count}"}
  end    
end

a = Interface.new
a.start