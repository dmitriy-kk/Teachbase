class Station
  include InstanceCounter
  include Validate

  @@stations = []
  attr_reader :name, :trains
  
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    self.register_instances
  end

  def validate!
    raise "Название станции обязательно для заполнения!!!" if self.name.empty?
  end

  def add_train(train)
    @trains << train
  end
    
  def departure_train(train)
    @trains.delete(train)
  end

  def block_trains
    self.trains.each do |t|
      yield(t)
    end
  end
end