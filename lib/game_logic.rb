# frozen_string_literal: true

# This module implements methods that are used in the game logic
module GameLogic
  MAX_LINES_FILE = 61_406

  def word_from_dictionary
    dictionary = File.open('5desk.txt', 'r')
    random_line_number.times { dictionary.gets }
    word = dictionary.gets.chomp.downcase
    dictionary.close
    return word if valid_word?(word)

    word_from_dictionary
  end

  def create_save_file(hash)
    Dir.mkdir('./lib/saves') unless Dir.exist?('./lib/saves')
    generate_filename
    File.open(@save_name, 'w') { |file| file.write(hash.to_json) }
  end

  def all_saves
    Dir['./lib/saves/*']
  end

  def read_json(filename)
    file = File.read(filename)
    File.delete(filename)
    JSON.parse(file)
  end

  private

  def generate_filename
    @save_name = "./lib/saves/#{Time.now.to_i}.json"
  end

  def valid_word?(word)
    word.length.between?(5, 12)
  end

  def random_line_number
    Random.rand(1..MAX_LINES_FILE) - 1
  end
end

