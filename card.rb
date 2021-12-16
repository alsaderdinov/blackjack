# frozen_string_literal: true

class Card
  attr_reader :suit, :value, :card

  SUITS = %w[♠ ♦ ♥ ♣].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize
    @suit = SUITS.sample
    @value = VALUES.sample
    @card = []
    init_card
  end

  def init_card
    @card << value.to_s + suit
  end
end
