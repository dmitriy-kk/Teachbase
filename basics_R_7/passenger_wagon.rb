class PassengerWagon < Wagon
  attr_reader :capacity, :take_seat, :available_seat
  def initialize(capacity)
    @type = :passenger
    @take_seat = 0
    @capacity = capacity
    @available_seat = capacity
    super
  end

  def boarding
    if self.take_seat < self.capacity && self.available_seat >= 0
      self.take_seat += 1
      self.available_seat -= 1
    else
      puts "Свободных мест нет"
    end
  end

  protected
  attr_writer :take_seat, :available_seat  
end