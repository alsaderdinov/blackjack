# frozen_string_literal: true

require_relative 'card'

class Deck
  def initialize
    @deck = create_deck
  end

  def create_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck.shuffle
  end

  def hand_over
    @deck.shift
  end
end
