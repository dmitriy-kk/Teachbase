# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(capacity)
    @type = :cargo
    super
  end

  def loading(volume)
    return 'Вагон заполнен' if free_capacity < volume

    self.used_capacity += volume
  end
end
