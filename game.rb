# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'hand'
require_relative 'bank'

BET = 10

class Game
  attr_reader :player, :dealer
  attr_accessor :bank

  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new(name = 'Dealer')
    @bank = Bank.new
    start_game
  end

  def start_game
    2.times { @player.take_card }
    2.times { @dealer.take_card }
    make_bet
  end

  def drop_cards
    @player.drop_cards
    @dealer.drop_cards
  end

  def make_bet
    @player.money -= BET
    @dealer.money -= BET
    bank.money += BET * 2
  end

  def victory
    if @player.points > 21 && @dealer.points > 21
      'nobody'
    elsif @player.points == @dealer.points
      @player.money += BET
      @dealer.money += BET
      bank.money = 0
      'draw'
    elsif @player.points < 22 && @dealer.points > 21
      @player.money += bank.money
      bank.money = 0
      'player'
    elsif @player.points > 21 && @dealer.points < 22
      @dealer.money += bank.money
      bank.money = 0
      'dealer'
    elsif @player.points > @dealer.points
      @player.money += bank.money
      bank.money = 0
      'player'
    elsif @player.points < @dealer.points
      @player.money += bank.money
      bank.money = 0
      'dealer'
    end
  end
end
