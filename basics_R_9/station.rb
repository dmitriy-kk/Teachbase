# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  @@stations = []

  attr_reader :name, :trains

  def self.all
    @@stations
  end
  
  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /[a-z]/i
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instances
  end

  def add_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def block_trains(&block)
    trains.each(&block)
  end

  def trains_by_type(type)
    @trains.select { |train| train(type) == type }.size
  end

end
