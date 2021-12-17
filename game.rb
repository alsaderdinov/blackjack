# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'hand'
require_relative 'bank'

BET = 10

class Game
  attr_reader :player, :dealer, :deck, :hand
  attr_accessor :bank

  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new(name = 'Dealer')
    @bank = Bank.new
    @deck = Deck.new
    start_game
  end

  def start_game
    init_starting_cards
    make_bet
  end

  def take_card(gamer)
    gamer.hand.cards << deck.hand_over if gamer.hand.less_three_cards?
  end

  def init_starting_cards
    2.times { @player.hand.cards << deck.hand_over }
    2.times { @dealer.hand.cards << deck.hand_over }
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
    if @player.hand.points > 21 && @dealer.hand.points > 21
      :nobody
    elsif @player.hand.points == @dealer.hand.points
      @player.money += BET
      @dealer.money += BET
      bank.money = 0
      :draw
    elsif @player.hand.points < 22 && @dealer.hand.points > 21
      @player.money += bank.money
      bank.money = 0
      :player
    elsif @player.hand.points > 21 && @dealer.hand.points < 22
      @dealer.money += bank.money
      bank.money = 0
      :dealer
    elsif @player.hand.points > @dealer.hand.points
      @player.money += bank.money
      bank.money = 0
      :player
    elsif @player.hand.points < @dealer.hand.points
      @player.money += bank.money
      bank.money = 0
      :dealer
    end
  end
end
