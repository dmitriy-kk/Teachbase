class Train
  include CompanyName
  include InstanceCounter

  @@trains = {}
  @@find

  def self.find
    puts "Ведите номер поезда:"
    name = gets.chomp.to_i
    if @@trains.include?(name)
      @@find = @@trains[name]
    else
      nil
    end
  end
  
  attr_reader :name, :location_station, :wagons, :route
  attr_writer :wagons

  def initialize(name)
    @wagons = []
    @current_speed = 0
    #@route = []
    @location_station = location_station
    @name = name
    inter_company_name
    self.register_instances
    @@trains[name] = self
  end

  def speed_up(up)
    @current_speed += up
  end

  def speed_down(down)
    @current_speed -= down
      if @current_speed < 0
        self.current_speed = 0
      else
        self.current_speed
      end
  end

   def add_wagon(wagon)
    if @current_speed == 0
      @wagons << wagon
    else
      puts "Остановите поезд"
    end
  end

  def delete_wagon
    if @current_speed == 0
      @wagons.pop
    else
      puts "Остановите поезд"
    end
  end

  def add_route(route)
    @route = route.list_station
    @location_station = @route[0]
    @location_station.add_train(self)
  end

  def station_up
    @location_station.departure_train(self)
    @location_station = @route[@route.index(@location_station) + 1]
    @location_station.add_train(self)
  end

  def station_down
    @location_station.departure_train(self)
    @location_station = @route[@route.index(@location_station) - 1]
    @location_station.add_train(self)
  end

  protected #методы не являються интерфейсами класса

  attr_accessor :previous_station, :next_station, :current_speed
  attr_reader 
  
  def stop
    self.current_speed = 0
  end

  def previous_next_station
    @previous_station = @route[@route.index(@location_station) - 1]
    @next_station = @route[@route.index(@location_station) + 1]
  end

end