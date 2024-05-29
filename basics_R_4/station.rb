class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def add_train(train)
    #if train.location_station.name == @name
      @trains << train
    else
      puts "Поезда нет на станции"
    end
  end
    
  def departure_train(train)
    @trains.delete(train)
  end
end