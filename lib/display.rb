# frozen_string_literal: true

# This module is responsible for all the outputs of the game
module Display
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/LineLength
  def output(code)
    outputs = {
      'ask_mode' => ask_mode,
      'ask_guess' => 'Enter a letter or type save to save your progress: ',
      'invalid_mode' => "#{red('Invalid mode')}\nType 1 to play a new game or 2 to load a game",
      'invalid_guess' => "#{red('Invalid guess')}\nEnter ONLY one letter or type save to save your progress",
      'already_guessed' => "#{red('You already guessed this letter')}\nEnter ONLY one letter or type save to save your progress",
      'remaining_guesses' => pink("Incorrect guesses remaining: #{@remaining_guesses}"),
      'guessed_letters' => pink("Guessed Letters: #{@guessed_letters.join(' ')}"),
      'obfuscated_word' => obfuscate_word,
      'word_length' => "The word has #{@word.length} letters",
      'congratulations' => 'Congratulations!!! You discovered the word!',
      'defeat' => 'Sorry, but you lost. The word was: ',
      'save_file' => "Your game was saved. The name of the file is: #{green(@save_name[12..nil])}",
      'ask_file' => 'Type the respective number of your save file',
      'no_files' => red('There are no save files, a new game will start')
    }
    puts outputs[code]
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/LineLength

  def each_turn_output
    output('remaining_guesses')
    output('obfuscated_word')
    output('guessed_letters')
    output('ask_guess')
  end

  def final_output
    if @win
      output('congratulations')
    elsif @guess == 'save'
      output('save_file')
    else
      output('defeat')
      puts @word
    end
  end

  def file_selection(array)
    array.each_index { |index| puts "#{light_blue('[')}#{index}#{light_blue(']')} #{array[index][12..nil]}" }
  end

  private

  def ask_mode
    "Choose an option:\n#{light_blue('[')}1#{light_blue(']')} New Game\n#{light_blue('[')}2#{light_blue(']')} Load Game"
  end

  def obfuscate_word
    @word.split('').map { |letter| @guessed_letters.include?(letter) ? letter : '_' }.join
  end

  def colorize(string ,color_code)
    "\e[#{color_code}m#{string}\e[0m"
  end

  def red(string)
    colorize(string, 31)
  end

  def green(string)
    colorize(string, 32)
  end

  def yellow(string)
    colorize(string, 33)
  end

  def blue(string)
    colorize(string, 34)
  end

  def pink(string)
    colorize(string, 35)
  end

  def light_blue(string)
    colorize(string, 36)
  end
end
