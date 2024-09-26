class Player
  include Cash
  include Validation

  validate :name, :presence
     
  attr_accessor :name, :card_draw
  
  def initialize(name)
    @name = name
    @wallet = 100
    @card_draw = []
    validate!
  end 
end