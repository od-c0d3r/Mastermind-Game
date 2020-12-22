# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Game
  attr_reader :board, :player1

  def initialize(player1, player2 = nil, type = nil, difficulty = nil)
    @player1 = Player.new(player1)
    @player2 = player2
    @type = type
    @difficulty = difficulty
    @board = Board.new(@player1, @player2)
  end

  def valid_input?(input)
    !!input.match(/\A[rgby]{4}\z/i)
  end

  def code_broke?(input)
    input == board.code_maker_board
  end

  def store_code(input, index)
    board.code_breaker_board[index] = input
  end

  def feedback(input)
    current_feedback = []
    input.each_index do |index|
      if input[index] == board.code_maker_board[index]
        current_feedback << '1'
        next
      elsif board.code_maker_board.include? input[index]
        current_feedback << '0'
        next
      end
    end
    current_feedback.shuffle
  end

  def store_feedback(input, index)
    board.pins_board[index] = input
  end
end
