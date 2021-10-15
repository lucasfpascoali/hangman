require 'game_logic'
require 'display'

class Game
  include GameLogic
  include Display

  attr_reader :word

  def initialize
    ask_mode
    gets.chomp == '1' ? new_game : load_game
  end

  private

  def new_game
    # TO DO
  end

  def load_game
    # TO DO
  end
end