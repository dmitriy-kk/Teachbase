class CargoWagon < Wagon
attr_reader :capacity, :take_tonnage, :available_tonnage
  def initialize(capacity)
    @type = :cargo
    @take_tonnage = 0
    @capacity = capacity
    @available_tonnage = capacity
    super
  end

  def loading(volume)
    if self.take_tonnage < self.capacity && self.available_tonnage - volume >= 0
      self.take_tonnage += volume
      self.available_tonnage -= volume
    else
      puts "Вагон заполен"
    end
  end

  protected
  attr_writer :take_tonnage, :available_tonnage
end