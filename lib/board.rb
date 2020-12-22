# frozen_string_literal: true

class Board
  attr_reader :code, :code_maker_board, :breaker_colors
  attr_accessor :code_breaker_board, :pins_board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @code_breaker_board = Array.new(12, [' ', ' ', ' ', ' '])
    @code_maker_board = %w[r g b y].shuffle
    @pins_board = Array.new(12, [' ', ' ', ' ', ' '])
    @code = ['|  r =-> Red   |   g =-> Green   |', '|  b =-> Blue  |  y =-> Yellow   |', '        |  w =-> White   |',
             '0 =-> Right color and position', '1 =-> Right color, wrong position']
  end

  def current_board
    current_board = []
    (0..12).each do |index|
      if [0, 1, 2, 3, 4, 5, 6, 7, 8].include? index
        current_board.unshift("  #{index + 1}  | [#{code_breaker_board[index][0]}][#{code_breaker_board[index][1]}]" /
        "[#{code_breaker_board[index][2]}][#{code_breaker_board[index][3]}] [#{pins_board[index].join}] |\n")
      end
      if [10, 11].include? index
        current_board.unshift("  #{index + 1} | [#{code_breaker_board[index][0]}][#{code_breaker_board[index][1]}]" /
        "[#{code_breaker_board[index][2]}][#{code_breaker_board[index][3]}] [#{pins_board[index].join}] |\n")
      end
      next unless index == 12

      current_board.unshift("     | [#{code_maker_board[0].gsub(/[rgby]/, '#')}]" /
      "[#{code_maker_board[1].gsub(/[rgby]/, '#')}][#{code_maker_board[2].gsub(/[rgby]/, '#')}]" /
      "[#{code_maker_board[3].gsub(/[rgby]/, '#')}]        |\n")
    end
    current_board
  end
end
