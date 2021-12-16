# frozen_string_literal: true

require_relative 'hand'
require_relative 'card'
require_relative 'bank'

class Player
  attr_accessor :money, :name

  def initialize(name)
    @name = name
    @hand = Hand.new
    @money = 100
  end

  def take_card
    @hand.take_card
  end

  def points
    @hand.points
  end

  def drop_cards
    @hand.drop_cards
  end

  def cards
    @hand.cards.each { |card| puts "#{card.value}#{card.suit}" }
  end
end
