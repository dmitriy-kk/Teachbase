class CargoTrain < Train
  attr_reader :name
  def initialize(name)
    @name = name
    @current_speed = 0
    @wagons = []
  end
end