# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(capacity)
    @type = :passenger
    super
  end

  def boarding
    return 'Свободных мест нет' if free_capacity < 1

    self.used_capacity += 1
  end
end
