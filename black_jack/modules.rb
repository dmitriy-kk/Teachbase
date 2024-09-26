module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  module ClassMethods
    attr_reader :validations

    def validate(attribute, type, *args)
      @validations ||= []
      @validations << [attribute, type, args]
    end

    protected

    def validate_presence(attribute)
      raise 'Имя обязательно для ввода' if attribute.nil?
      raise 'Введена пустая строка, это не допустимо' if attribute.empty?
    end

    def validate_format(attribute, args)
      raise "#{attribute} не коректный формат" if attribute !~ args.first
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = instance_variable_get("@#{validation.first}")
        self.class.send :validate_presence, attribute if validation[1] == :presence
        self.class.send :validate_format, attribute, validation.last if validation[1] == :format
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end

module Cash
  
  attr_accessor :wallet

  def top_up_bank
    self.wallet -= 10
  end

  def top_up_wallet(bank)
    self.wallet += bank
  end
end


module Menu
  private

  ACTION_NUMBER = { '1' => 'draw', '2' => 'add_card', '3' => 'result_game'}.freeze

  def action_selection(choice)
    method(ACTION_NUMBER[choice]).call
  rescue StandardError
    puts "Введен неверный номер команды"
  end

  def get_user_input(message)
    puts(message)
    gets.chomp
  end
end

module Point
  private
  def point(card_draw)
    p1 = 0
    card_draw.each do |i|
      i.each_value do |p|
        p1 += p
      end
    end
    p1
    if p1 > 21 && card_draw.to_s.include?("A") == true
      p1 = p1 - 10
    else
      p1
    end      
  end
end

module Finish_game
  private
  def finish_game
    puts "баланс игрока: #{@player.wallet}"
    puts "баланс дилера: #{@dealer.wallet}"
    @dealer.card_draw.clear
    @player.card_draw.clear
    puts %( Нажмите:
            Продолжить игру - 1
            Завершить игру - 4)
  end
end

module Output_results
  private
  def output_results_dealer
    puts "Карты #{@dealer.name}"
    @dealer.card_draw.each{ |i| i.each{ |k, v| puts k.to_s} }
    puts "Очки: #{point(@dealer.card_draw)}"
    puts
  end

  def output_results_player
    puts "Карты #{@player.name}" 
    @player.card_draw.each{ |i| i.each{ |k, v| puts k.to_s} }
    puts "Очки: #{point(@player.card_draw)}"
    puts
  end

  def hide_output_results_dealer
    puts "Карты #{@dealer.name}"
    @dealer.card_draw.each{ |i| i.each{ |k, v| puts k.to_s.gsub(/\w|\W/, '*')} }
    puts "Очки: #{point(@dealer.card_draw).to_s.gsub(/\w|\W/, '*')}"
    puts
  end

end

