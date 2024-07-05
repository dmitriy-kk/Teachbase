# frozen_string_literal: true

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

  private

  def validate!
    raise 'Название станции обязательно для заполнения!!!' if name.empty?
  end
end
