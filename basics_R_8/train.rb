# frozen_string_literal: true

class Train
  attr_accessor :wagons
  attr_reader :number, :location_station, :route, :type

  NUMBER_FORMAT = /(\d{3}|[a-z]{3})-?(\d{2}|[a-z]{2})/i.freeze

  include CompanyName
  include InstanceCounter
  include Validate

  @@trains = []

  def self.find(number)
    @@trains.select { |t| t.number == number }.first
  end

  def initialize(number)
    @number = number
    @type = type
    validate!
    @current_speed = 0
    @location_station = location_station
    @wagons = []
    inter_company_name
    register_instances
    @@trains << self
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

  attr_accessor :previous_station, :next_station, :current_speed

  def validate!
    raise 'Номер поезда обязателен для ввода' if number.empty?
    raise 'Номер задан в неправильном формате' if number !~ NUMBER_FORMAT
  end

  def stop
    self.current_speed = 0
  end

  def previous_next_station
    @previous_station = @route[@route.index(@location_station) - 1]
    @next_station = @route[@route.index(@location_station) + 1]
  end
end
