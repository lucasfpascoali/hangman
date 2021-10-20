# frozen_string_literal: true

require './lib/game_logic'
require './lib/display'
require 'json'

# This class is responsible for control all the game
class Game
  include GameLogic
  include Display

  attr_reader :remaining_guesses, :guessed_letters

  def initialize
    @word = word_from_dictionary
    @save_name = ''
    @remaining_guesses = 10
    @guessed_letters = []
    load_game if mode_selection == '2'
    play
  end

  private

  def mode_selection
    output('ask_mode')
    mode = gets.chomp
    return mode if %w[1 2].include?(mode)

    output('invalid_mode')
    mode_selection
  end

  def save_game
    save = {
      remaining_guesses: @remaining_guesses,
      guessed_letters: @guessed_letters,
      word: @word
    }
    create_save_file(save)
  end

  def load_game
    @save_files = all_saves
    if @save_files.empty?
      output('no_files')
      sleep(2)
      return nil
    end

    output('ask_file')
    file_selection(@save_files)
    loaded_file = read_json(@save_files[file_index_input])
    @remaining_guesses = loaded_file['remaining_guesses']
    @guessed_letters = loaded_file['guessed_letters']
    @word = loaded_file['word']
  end

  def file_index_input
    file_index = gets.chomp.to_i
    return file_index unless @save_files[file_index].nil?

    output('invalid_file')
    file_index_input
  end

  # rubocop:disable Metrics/MethodLength
  def play
    output('word_length')
    while @remaining_guesses.positive?
      each_turn_output
      @guess = player_guess

      if @guess == 'save'
        save_game
        break
      end

      @guessed_letters.push(@guess)
      @remaining_guesses -= 1 unless guess_is_right?

      verify_win
      break if @win
    end

    final_output
  end
  # rubocop:enable Metrics/MethodLength

  def guess_is_right?
    @word.include?(@guess)
  end

  def verify_win
    @win = @word.split(//).all? { |letter| guessed_letters.include?(letter) }
  end

  def player_guess
    guess = gets.chomp.downcase
    return guess if valid_guess?(guess) && !duplicated_guess?(guess)

    player_guess
  end

  def valid_guess?(guess)
    unless guess.length == 1 || guess == 'save'
      output('invalid_guess')
      return false
    end
    true
  end

  def duplicated_guess?(guess)
    if @guessed_letters.include?(guess)
      output('already_guessed')
      output('guessed_letters')
      return true
    end
    false
  end
end
