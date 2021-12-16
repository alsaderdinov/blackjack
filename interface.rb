# frozen_string_literal: true

require_relative 'game'

class Interface
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
        another_round
      when 2
        @game.dealer.take_card
      when 3
        @game.player.take_card
        @game.dealer.take_card
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
    puts 'Player cards'
    @game.player.cards
    puts @game.player.points

    puts '-' * 50

    puts 'Dealer cards'
    @game.dealer.show_cards
    puts @game.dealer.points

    puts @game.victory
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
end
