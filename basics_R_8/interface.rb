# frozen_string_literal: true

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
      choice = get_user_input('Введите номер команды: ')
      break if choice == '123'

      action_selection(choice)
    end
  end

  # 1
  def station_new
    name = get_user_input('Введите название создоваемой станции').capitalize.to_s.lstrip
    @stations[name] = Station.new(name)
    puts "Станция #{name} построена"
  rescue RuntimeError => e
    puts e
    retry
  end

  # 2
  def train_new
    number = get_user_input("Введите номер поезда формате: три буквы или три цифры +'-'(может быть или не быть) + две буквы или цифры").downcase
    type = get_user_input('Введите тип поезда если Пассажиркий - 1, если грузовой - 2').to_i
    if type == 1
      @trains[number] = PassengerTrain.new(number)
      puts "Построен пассажирский поезд: #{@trains[number].number}"
    elsif type == 2
      @trains[number] = CargoTrain.new(number)
      puts "Построен грузовой поезд: #{@trains[number].number}"
    else
      puts 'Такого типа поездов не существует'
    end
  rescue RuntimeError => e
    puts e
    retry
  end

  # 3
  def route_new
    puts
    name = get_user_input('Введите название маршрута').downcase.to_s
    station1 = get_user_input('Введите начальную точку маршрута').capitalize.to_s.lstrip
    first_station = @stations[station1]
    station2 = get_user_input('Ввведите конечную точку маршрута').capitalize.to_s.lstrip
    final_station = @stations[station2]
    @routes[name] = Route.new(first_station, final_station)
    puts "Мршрут #{name} создан!"
  rescue RuntimeError => e
    puts e
    puts 'Маршрут не создан!!!'
  end

  # 4
  def add_down_station_route
    name_route = get_user_input('Введите название маршрута').downcase.to_s
    name = get_user_input('Введите название станции').capitalize.to_s.lstrip
    type = get_user_input('Для добавления станции нажмите - 1, удаления - 2').to_i
    if @stations.include?(name)
      if type == 1
        @routes[name_route].add_intermediate_station(@stations[name])
      elsif type == 2
        @routes[name_route].delete_station(@stations[name])
      else
        puts 'Номер команды введен неверно'
      end
    else
      puts 'Такой станции не существует, создайте станцию'
    end
  rescue StandardError
    puts 'Название маршрута введено не верно!!!'
    puts 'Список созданных маршрутов:'
    routes.each_key { |k| puts k }
  end

  # 5
  def add_route
    name_route = get_user_input('Введите название маршрута').downcase.to_s
    number = get_user_input('Введите номер поезда').downcase.to_s
    @trains[number].add_route(@routes[name_route])
  rescue StandardError
    puts 'При вводе названия маршрута или номера поезда допущена ошибка!!!'
    puts 'Список созданных маршрутов:'
    routes.each_key { |k| puts k }
    puts 'Список созданных поездов:'
    trains.each_value { |v| puts v.number }
  end

  # 6
  def add_wagon
    number = get_user_input('Введите номер поезда').downcase.to_s
    capacity = get_user_input('Введите количество мест или объем вагона.').to_i
    if @trains[number].type == :passenger
      @trains[number].add_wagon(PassengerWagon.new(capacity))
      puts "К поезду #{number} прицеплено вагонов: #{@trains[number].wagons.count}"
    elsif @trains[number].type == :cargo
      @trains[number].add_wagon(CargoWagon.new(capacity))
      puts "К поезду #{number} прицеплено вагонов: #{@trains[number].wagons.count}"
    end
  rescue StandardError
    puts 'Поезд не создан или допущена ошибка при вводе!!!'
    puts 'Список созданных поездов:'
    trains.each_value { |v| puts v.number }
  end

  # 7
  def delete_wagon
    number = get_user_input('Введите номер поезда').downcase.to_s
    @trains[number].delete_wagon
    puts "К поезду #{number} прицеплено #{@trains[number].wagons.count} вагонов"
  rescue StandardError
    puts 'Поезд не создан или допущена ошибка при вводе!!!'
    puts 'Список созданных поездов:'
    trains.each_value { |v| puts v.number }
  end

  # 8
  def drive_station_up_down
    number = get_user_input('Введите номер поезда').downcase.to_s
    puts %(
          123. Выход
          1. Переместить поезд на станцию вперед.
          2. Переместить на станцию назад.
      )

    loop do
      puts 'Введите номер команды: '
      choice = gets.to_i
      case choice
      when 123
        break
      when 1
        @trains[number].station_up
        puts "Поезд прибыл на станцию #{@trains[number].location_station.name}"
      when 2
        @trains[number].station_down
        puts "Поезд прибыл на станцию #{@trains[number].location_station.name}"
      end
    end
  rescue StandardError
    puts 'Поезд не создан или допущена ошибка при вводе!!!'
    puts 'Список созданных поездов:'
    trains.each_value { |v| puts v.number }
  end

  # 9
  def list_station_list_trins_at_station
    puts %(
          123. Выход
          1. Просмотр списка станций.
          2. Просмотр списка поездов на станции.
          3. Просотр списка вагонов поезда.
      )

    loop do
      puts 'Введите номер команды: '
      choice = gets.to_i
      case choice
      when 123
        break
      when 1
        puts 'Список станций:'
        @stations.each_value { |v| puts v.name }
      when 2
        begin
          name = get_user_input('Введите название станции').capitalize.to_s.lstrip
          puts 'Список поездов:'
          @stations[name].block_trains do |t|
            puts "Номер поезда: #{t.number}; тип: #{t.type}; количество вагонов: #{t.wagons.count}."
          end
        rescue StandardError
          puts 'Станция не создавалась или допущена ошибка при вводе!!!'
        end
      when 3
        begin
          number = get_user_input('Введите номер поезда').downcase.to_s
          if trains[number].type == :passenger
            trains[number].block_wagons do |w|
              puts %(Номер вагона #{trains[number].wagons.index(w) + 1}; тип #{w.type};
                    свободных мест: #{w.free_capacity}; занятых мест: #{w.used_capacity}.)
            end
          end
          if trains[number].type == :cargo
            trains[number].block_wagons do |w|
              puts %(Номер вагона #{trains[number].wagons.index(w) + 1}; тип #{w.type};
                    свободный объём: #{w.free_capacity}; занятый объём: #{w.used_capacity}.)
            end
          end
        rescue StandardError
          puts 'Поезд не создан или допущена ошибка при вводе!!!'
          puts 'Список созданных поездов:'
          trains.each_value { |v| puts v.number }
        end
      end
    end
  end

  # 10
  def take_seat
    number = get_user_input('Введите номер поезда').downcase.to_s
    num = get_user_input('Введите номер вагона').to_i
    if trains[number].type == :passenger
      trains[number].wagons[num - 1].boarding
      puts 'Пассажир сел в вагон.'
    elsif trains[number].type == :cargo
      volume = get_user_input('Введите объем загружаемого груза.').to_i
      trains[number].wagons[num - 1].loading(volume)
    end
  rescue StandardError
    puts 'Поезд не создан или допущена ошибка при вводе!!!'
    puts 'Список созданных поездов:'
    trains.each_value { |v| puts "номер поезда: #{v.number}; количество вагонов: #{v.wagons.count}" }
  end

  private

  ACTION_NUMBER = { '1' => 'station_new', '2' => 'train_new', '3' => 'route_new',
                    '4' => 'add_down_station_route', '5' => 'add_route', '6' => 'add_wagon',
                    '7' => 'delete_wagon', '8' => 'drive_station_up_down', '9' => 'list_station_list_trins_at_station',
                    '10' => 'take_seat' }.freeze

  def action_selection(choice)
    method(ACTION_NUMBER[choice]).call
  end

  def get_user_input(message)
    puts(message)
    gets.chomp
  end
end

a = Interface.new
a.start
