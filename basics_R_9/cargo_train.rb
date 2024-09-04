# frozen_string_literal: true

class CargoTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /(\d{3}|[a-z]{3})-?(\d{2}|[a-z]{2})/i.freeze
  def initialize(number)
    @type = :passenger
    super
  end
end
