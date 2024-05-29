class PassengerTrain < Train
  attr_reader :name, :current_speed, :wagons
  def initialize(name)
    @name = name
    @current_speed = 0
    @wagons = []
  end
end