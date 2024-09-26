class Interfuice
  include Validation
  include Point
  include Menu
  include Finish_game
  include Output_results
  attr_accessor :player, :dealer, :game
  def initialize
    @player = player
    @dealer = Dealer.new
    @game = game
  end

  def start
    name = get_user_input("Для начала игры введите имя").capitalize.to_s.lstrip
    @player = Player.new(name)
    draw
    loop do
      choice = get_user_input("Введите номер команды")
      break if choice == '4' 
      action_selection(choice)
    end
  rescue RuntimeError => e
    puts e
    retry
  end

  #1
  def draw
    @game = Game.new
    @game.bank = 20
    @dealer.top_up_bank 
    @player.top_up_bank
    @game.draw(2)
    @player.card_draw = @game.card
    @game.draw(2)
    @dealer.card_draw = @game.card
    hide_output_results_dealer
    output_results_player
    puts %( Выберите команду:
            Пропустить ход - 3
            Добавить карту - 2
            Открыть карты - 3)
  end
  #2
  def add_card
    @game.draw(1)
    @player.card_draw << @game.card[0] if @player.card_draw.count <= 1
    hide_output_results_dealer
    output_results_player
    puts %( Нажмите:
            Открыть карты - 3)

  end
  #3
  def result_game
    if point(@dealer.card_draw) <= 17
      @game.draw(1)
      @dealer.card_draw << @game.card[0]
    end
    
    point_player = point(@player.card_draw)
    point_dealer = point(@dealer.card_draw)
    output_results_dealer
    output_results_player
    if point_dealer > 21 && point_player > 21 || point_dealer == point_player
      puts "Ничья"
      @player.top_up_wallet(10)
      @dealer.top_up_wallet(10)
      finish_game      
    elsif point_player > 21 && point_dealer <= 21 || point_dealer > point_player && point_dealer <= 21  
      puts "Вы проиграли"
      @dealer.top_up_wallet(@game.bank)
      finish_game      
    else
      puts "Вы выиграли"
      @player.top_up_wallet(@game.bank)
      finish_game
    end
  end    
end

    
