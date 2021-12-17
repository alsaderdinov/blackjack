# frozen_string_literal: true

require_relative 'card'
require_relative 'player'
require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def less_three_cards?
    @cards.length < 3
  end

  def less_seventeen_points?
    points < 17
  end

  def points
    values = assign_points
    values.each do |value|
      values[values.index(value)] = 11 if values.sum < 21 && value == 1 && (values.sum + 10 < 22)
    end
    values.sum
  end

  def drop_cards
    @cards = []
  end

  private

  def assign_points
    values = []
    @cards.each do |card|
      values << case card.value
                when 'J', 'Q', 'K'
                  10
                when 'A'
                  1
                else
                  card.value
                end
    end
    values
  end
end
