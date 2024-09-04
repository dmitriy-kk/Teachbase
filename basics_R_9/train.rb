# frozen_string_literal: true

class Train
  include CompanyName
  include InstanceCounter
  include Validation
  include Accessor

  attr_reader :number, :location_station, :type, :wagons, :route

  @@trains = []

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /(\d{3}|[a-z]{3})-?(\d{2}|[a-z]{2})/i.freeze

  def self.find(number)
    @@trains.select { |t| t.number == number }.first
  end

  def initialize(number)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
    validate!
    @@trains << self
    inter_company_name
    register_instances
    @location_station = location_station
  end

  def speed_up(upp)
    @current_speed += upp
  end

  def speed_down(down)
    @current_speed -= down
    if @current_speed.negative?
      self.current_speed = 0
    else
      current_speed
    end
  end

  def add_wagon(wagon)
    @wagons << wagon if @current_speed.zero?
  end

  def delete_wagon
    @wagons.pop if @current_speed.zero?
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

  def block_wagons(&block)
    wagons.each(&block)
  end

  protected # методы не являються интерфейсами класса

  attr_accessor_with_history :current_speed, :location_station
  attr_accessor :previous_station, :next_station
  attr_writer :wagons

  def stop
    self.current_speed = 0
  end

  def previous_next_station
    @previous_station = @route[@route.index(@location_station) - 1]
    @next_station = @route[@route.index(@location_station) + 1]
  end
end
