# frozen_string_literal: true

class Dealer
  include Cash
  attr_accessor :card_draw
  attr_reader :name

  def initialize
    @name = 'Dealer'
    self.wallet = 100
    @card_draw = []
  end
end
