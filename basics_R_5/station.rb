class Station
  include InstanceCounter

  @@stations = []
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    self.register_instances
  end

  def self.all
    @@stations
  end

  def add_train(train)
    @trains << train
  end
    
  def departure_train(train)
    @trains.delete(train)
  end
end