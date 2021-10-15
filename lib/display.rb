module Display
  def ask_mode
    puts 'Would you like to: '
    puts "#{'['.light_blue}1#{']'.blue} New Game"
    puts "#{'['.light_blue} 2 #{']'.blue} Load Game"
  end
end
