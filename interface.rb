# frozen_string_literal: true

require_relative 'game'

class Interface
  attr_reader :game

  def greetings
    puts "What's your name?"
    @name = gets.chomp
    @game = Game.new(@name)
    puts "Hello #{@game.player.name}"
  end

  def start_game
    greetings
    loop do
      actions
      action = gets.to_i
      case action
      when 1
        open_cards
        show_winner
        another_round
      when 2
        show_player_cards
        hide_dealer_cards
        @game.take_card(game.dealer)
      when 3
        @game.take_card(game.player)
        @game.take_card(game.dealer) if @game.dealer.hand.less_seventeen_points?
      end
    end
  end

  def actions
    puts 'Choose action'
    puts '1: Open cards'
    puts '2: Skip'
    puts '3: Take card'
  end

  def open_cards
    show_player_cards
    show_dealer_cards
  end

  def hide_dealer_cards
    sep
    puts 'Dealer Cards'
    @game.dealer.hand.cards.size.times { puts '**' }
    sep
  end

  def show_dealer_cards
    sep
    puts 'Dealer Cards'
    @game.dealer.hand.cards.each { |card| puts "#{card.value}#{card.suit}" }
    puts "Points #{@game.dealer.hand.points}"
    sep
  end

  def show_player_cards
    sep
    puts 'Player Cards'
    @game.player.hand.cards.each { |card| puts "#{card.value}#{card.suit} " }
    puts "Points #{@game.player.hand.points}"
    sep
  end

  def show_winner
    case @game.victory
    when :player
      puts "Congrats #{@game.player.name}! You win!"
      puts "Bank: #{@game.player.money}"
    when :dealer
      puts 'Dealer wins'
      puts "Bank: #{@game.dealer.money}"
    when :draw
      puts 'Draw'
    when :nobody
      puts 'Nobody'
    end
  end

  def another_round
    puts 'Wants play more?'
    puts 'Y/N'
    input = gets.chomp.downcase
    case input
    when 'y'
      @game.drop_cards
      @game.start_game
    when 'n'
      abort
    end
  end

  def sep
    puts '-' * 50
  end
end
