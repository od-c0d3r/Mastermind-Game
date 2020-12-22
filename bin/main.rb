# frozen_string_literal: true

require_relative '../lib/game'

def waiting_between
  sleep(1)
  (1..3).each do |i|
    print '.'
    sleep(0.4)
    puts '' if i == 3
  end
end

def copy_writer(string)
  string.split(//).push("\n").each { |char| print char; sleep(0.05) }
  waiting_between
end

def loading
  (1..10).each do |i|
    print '...'
    puts '100%' if i == 10
    sleep(0.1)
  end
end

def game_flow(game)
  system('clear') || system('cls')
  (0..11).each do |index| # 12 turns game
    puts game.board.code
    puts
    puts game.board.current_board
    puts

    # User input and validation
    print "Enter your guess colors with no spaces 'rgby' \n=> "
    input = gets.chomp.strip
    until game.valid_input?(input)
      puts "Invalid input 'r', 'g', 'b' or 'y' /> "
      input = gets.chomp.strip
    end
    current_code = input.split(//)
    if game.code_broke?(current_code)
      copy_writer('You beat me! We have a new MASTERMIND!')
      copy_writer('Play again ? (y/n)')
      try_again = gets.chomp
      until try_again == 'y' || 'n'
        print 'Invalid input \'y\' or \'n\' :> '
        try_again = gets.chomp
      end
      game_flow(game) if try_again == 'y'
      return
    end
    game.store_code(current_code, index)
    game.feedback(current_code)
    game.store_feedback(game.feedback(current_code), index)

    system('clear') || system('cls')
  end
  copy_writer('Better luck next time.')
  copy_writer('try again ? (y/n)')
  try_again = gets.chomp
  game_flow(game) if try_again == 'y'
end

system('clear') || system('cls')

puts "Starting 'MasterMind v1.0'"
loading
puts

system('clear') || system('cls')

puts "                 github.com/od-c0d3r
███╗░░░███╗░█████╗░░██████╗████████╗███████╗██████╗░███╗░░░███╗██╗███╗░░██╗██████╗░
████╗░████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗░████║██║████╗░██║██╔══██╗
██╔████╔██║███████║╚█████╗░░░░██║░░░█████╗░░██████╔╝██╔████╔██║██║██╔██╗██║██║░░██║
██║╚██╔╝██║██╔══██║░╚═══██╗░░░██║░░░██╔══╝░░██╔══██╗██║╚██╔╝██║██║██║╚████║██║░░██║
██║░╚═╝░██║██║░░██║██████╔╝░░░██║░░░███████╗██║░░██║██║░╚═╝░██║██║██║░╚███║██████╔╝
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝╚═════╝░
"
puts
puts 'Human, Please enter your name?'
game = Game.new(gets.chomp.strip, 'Smarticus')
sleep(1)
system('clear') || system('cls')

copy_writer("Hi, #{game.player1.name} !")
copy_writer("I'm Smarticus your AI opponent.")
copy_writer('let me introduce you to the game rules.')
copy_writer("The object of MASTERMIND is to guess a secret \ncode consisting of a series of 4 colors within 12 rounds.")
copy_writer("Each guest results in feedback narrowing \ndown the possibilities of the code.")
copy_writer("The winner is the player who solves his \nopponent's secret code.")
copy_writer('Let\'s Start.')
copy_writer('I just created my color code.')
copy_writer('Have a Good Cracking Time.')
print '↲ '
gets
system('clear') || system('cls')

game_finished = false
until game_finished
  game_flow(game)
  game_finished = true
end
