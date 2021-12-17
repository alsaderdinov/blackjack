# frozen_string_literal: true

require_relative 'hand'
require_relative 'card'
require_relative 'bank'

class Player
  attr_accessor :money, :name, :hand

  def initialize(name)
    @name = name
    @hand = Hand.new
    @money = 100
  end

  def drop_cards
    @hand.drop_cards
  end
end
