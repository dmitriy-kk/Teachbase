class Interface

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
      end
    end
  end

  
#1
  def station_new
    puts "Введите название создоваемой станции"
    name = gets.chomp.downcase.to_s
    @stations[name] = Station.new(name)
    puts "Станция #{name} построена"
  end
#2
  def train_new
      puts "Введите номер поезда"
      name = gets.chomp
      puts "Введите тип поезда если Пассажиркий - 1, если грузовой - 2"
      type = gets.chomp.to_i
      if type == 1
          @trains[name] = PassengerTrain.new(name.to_s)
          puts "Построен пассажирский поезд: #{@trains[name].name}"
      elsif type == 2
          @trains[name] = CargoTrain.new(name)
          puts "Построен грузовой поезд: #{@trains[name].name}"
      else
          puts "Такого типа поездов не существует"
      end
  end
#3 
  def route_new
    puts "Введите название маршрута"
    name = gets.chomp
    puts "Введите начальную точку маршрута"
    station1 = gets.chomp.downcase.to_s
    if @stations.include?(station1)
      first_station = @stations[station1]
    else
      puts "Для добавления в мршрут создайте станцию"
    end
    puts "Ввведите конечную точку маршрута"
    station2 = gets.chomp.downcase.to_s
    if @stations.include?(station2)
      final_station = @stations[station2]
    else
      puts "Для добавления в мршрут создайте станцию"
    end
    @routes[name] = Route.new(first_station, final_station)
  end
#4
  def add_down_station_route
    puts "Введите название маршрута"
    name_route = gets.chomp
    puts "Введите название станции"
    name = gets.chomp.downcase.to_s
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
  end
#5
  def add_route
    puts "Введите название маршрута"
    name_route = gets.chomp.to_s
    puts "Введите номер поезда"
    name = gets.chomp.to_s
    @trains[name].add_route(@routes[name_route])
  end
#6
  def add_wagon
    puts "Введите номер поезда"
    name = gets.chomp
    if @trains[name].class == PassengerTrain
      @trains[name].add_wagon(PassengerWagon.new)
      puts "К поезду #{name} прицеплено #{@trains[name].wagons.count} вагонов"
      puts "Список производителей вагонов: "
      @trains[name].wagons.each{|i| puts i.company_name}
    elsif @trains[name].class == CargoTrain
      @trains[name].add_wagon(CargoWagon.new)
      puts "К поезду #{name} прицеплено #{@trains[name].wagons.count} вагонов"
    else
      puts "Такого поезда нет в списке"
    end
  end
#7
  def delete_wagon
    puts "Введите номер поезда"
    name = gets.chomp
    @trains[name].delete_wagon
  end
#8
  def drive_station_up_down
    puts "Введите номер поезда"
    name = gets.chomp
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
          @trains[name].station_up
        when 2
          @trains[name].station_down
      end
    end
    puts "Поезд прибыл на станцию #{@trains[name].location_station.name}"
  end
#9
  def list_station_list_trins_at_station
    puts %(
          123. Выход
          1. Просмотр списка станций.
          2. Просмотр списка поездов на станции.
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
          puts "Введите название станции"
          name = gets.chomp.downcase.to_s
          puts "Список поездов:"
          puts @stations[name].trains.each {|train| puts train.name }
      end
    end
  end
end

a = Interface.new
a.start