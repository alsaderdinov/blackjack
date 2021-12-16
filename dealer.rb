# frozen_string_literal: true

require_relative 'player'
require_relative 'bank'

class Dealer < Player
  def cards
    @hand.cards.size.times { puts ' ** ' }
  end

  def show_cards
    @hand.cards.each { |card| puts "#{card.value}#{card.suit}" }
  end

  def take_card
    @hand.take_card if @hand.less_seventeen_points?
  end
end
