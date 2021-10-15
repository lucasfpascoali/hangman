# frozen_string_literal: true

# This module implements methods that are used in the game logic
module GameLogic
  MAX_LINES_FILE = 61_406

  def word_from_dictionary
    dictionary = File.open('5desk.txt', 'r')
    random_line_number.times { dictionary.gets }

    @word = ''
    loop do
      @word = dictionary.gets.chomp
      break if @word.length.between?(5, 12)
    end
    dictionary.close
  end

  def mode_selection

  end



  private

  def random_line_number
    Random.rand(1..MAX_LINES_FILE) - 1
  end
end
