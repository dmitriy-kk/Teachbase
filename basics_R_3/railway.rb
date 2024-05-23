class Station
attr_reader :name, :list_passenger, :list_cargo, :trains

  def initialize(name)
    @name = name
    @trains = []
    @list_passenger = []
    @list_cargo = []
  end

  def add_train(train)
    if train.location_station.name == @name
      @trains << train
        if train.tipe == 'passenger'
          @list_passenger << train.name
        else
          @list_cargo << train.name
        end
    else
      puts "Поезда нет на станции"
    end
  end

  def print_list_tipe
    puts %(
            Количество пассажирзких поездов #{@list_passenger.count}
            список имен пассажирских поезд: #{@list_passenger}
            Количество грузовых поездов: #{@list_cargo.count}
            список имен грузовых поездов: #{@list_cargo}
            )
  end

  def departure_train(train)
    if @trains.include? train
      @trains.delete(train)
      @list_passenger.delete(train)
      @list_cargo.delete(train)
    end
  end

end

class Route
  attr_reader :list_station

  def initialize (first_station, final_station)
    @first_station = first_station
    @final_station = final_station
    @list_station = [first_station, final_station]
  end

  def add_intermediate_station(station)
    @list_station.insert(-2, station)
  end

  def delete_station(station)
    @list_station.delete(station)
  end
end

class Train
  attr_reader :name, :tipe, :current_speed
  attr_accessor :number_of_wagons, :location_station, :previous_station, :next_station, :route
  def initialize(name, tipe, number_wagons, current_speed = 0)
    @name = name
    @tipe = tipe
    @number_of_wagons = number_wagons
    @current_speed = current_speed
    @route = []
  end

  def speed_up(up)
    @current_speed += up
  end

  def speed_down(down)
    @current_speed -= down
      if @current_speed < 0
        @current_speed = 0
      else
        @current_speed
      end
  end

  def stop
    @current_speed = 0
  end

  def add_wagon
    if @current_speed == 0
      @number_of_wagons += 1
    else
      puts "Остановите поезд"
    end
  end

  def delete_wagon
    if @current_speed == 0
      @number_of_wagons -= 1
    else
      puts "Остановите поезд"
    end
  end

  def add_route(route)
    @route = route.list_station
    @location_station = @route[0]
  end

  def station_up
    @location_station = @route[@route.index(@location_station) + 1]
  end

  def station_down
    @location_station = @route[@route.index(@location_station) - 1]
  end

  def previous_next_station
    @previous_station = @route[@route.index(@location_station) - 1]
    @next_station = @route[@route.index(@location_station) + 1]
  end

end

s1 = Station.new("s1")
s2 = Station.new("s2")
s3 = Station.new("s3")
s4 = Station.new("s4")

t1 = Train.new( "p1", 'passenger', 10, 0 )
t2 = Train.new( "c1", 'cargo', 100, 0 )

r1 = Route.new(s1, s2)
r1.add_intermediate_station(s3)
r1.add_intermediate_station(s4)

t1.add_route(r1)
t2.add_route(r1)

s1.add_train(t1)
s1.add_train(t2)

s1.print_list_tipe

puts t1.location_station.name
t1.station_up
puts t1.location_station.name

puts t2.location_station.name
t2.station_down
puts t2.location_station.name





