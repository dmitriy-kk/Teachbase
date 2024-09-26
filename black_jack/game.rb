# frozen_string_literal: true

class Game
  attr_accessor :bank, :deck_cards
  attr_reader :card

  def initialize
    @deck_cards = { 'A+' => 11, 'A<3' => 11, 'A^' => 11, 'A<>' => 11,
                    'K+' => 10, 'K<3' => 10, 'K^' => 10, 'K<>' => 10,
                    'Q+' => 10, 'Q<3' => 10, 'Q^' => 10, 'Q<>' => 10,
                    'J+' => 10, 'J<3' => 10, 'J^' => 10, 'J<>' => 10,
                    '10+' => 10, '10<3' => 10, '10^' => 10, '10<>' => 10,
                    '9+' => 9, '9<3' => 9, '9^' => 9, '9<>' => 9,
                    '8+' => 8, '8<3' => 8, '8^' => 8, '8<>' => 8,
                    '7+' => 7, '7<3' => 7, '7^' => 7, '7<>' => 7,
                    '6+' => 6, '6<3' => 6, '6^' => 6, '6<>' => 6,
                    '5+' => 5, '5<3' => 5, '5^' => 5, '5<>' => 5,
                    '4+' => 4, '4<3' => 4, '4^' => 4, '4<>' => 4,
                    '3+' => 3, '3<3' => 3, '3^' => 3, '3<>' => 3,
                    '2+' => 2, '2<3' => 2, '2^' => 2, '2<>' => 2 }
    @card = card
    @bank = 0
  end

  attr_writer :cars

  def draw(number_cards)
    card = []
    card << @deck_cards.sample(number_cards)
    @card = card
    @deck_cards.delete(@card)
  end
end
