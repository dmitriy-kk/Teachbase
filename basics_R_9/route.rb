# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation

  attr_reader :list_station

  validate :list_station, :type, Array

  def initialize(first_station, final_station)
    validate!(first_station, final_station)
    @list_station = [first_station, final_station]
    register_instances
  end

  def add_intermediate_station(station)
    @list_station.insert(-2, station)
  end

  def delete_station(station)
    @list_station.delete(station)
  end

  protected

  def validate!(first_station, final_station)
    raise 'Начальная станция маршрута не создана!!! Создайте станцию.' if first_station.class != Station
    raise 'Конечная станция маршрута не создана!!! Создайте станцию.' if final_station.class != Station
  end

end
