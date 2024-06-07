class Route

  include InstanceCounter

  attr_reader :list_station

  def initialize (first_station, final_station)
    @list_station = [first_station, final_station]
    self.register_instances
  end

  def add_intermediate_station(station)
    @list_station.insert(-2, station)
  end

  def delete_station(station)
    @list_station.delete(station)
  end
end