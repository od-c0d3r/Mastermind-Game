# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
  let(:new_game) { Game.new('player1') }
  let(:input) { 'rgby' }

  describe '#initialize' do
    it 'should creates a new instance of Game class' do
      expect(new_game).to be_instance_of Game
    end
    it 'should creates a new instance of Player class ' do
      expect(new_game.player1).to be_instance_of Player
    end
    it 'should creates a new instance of Board class ' do
      expect(new_game.board).to be_instance_of Board
    end
  end

  describe '#valid_input?' do
    it 'should return true if input is 4 chars of [rgby]' do
      expect(new_game.valid_input?(input)).to be true
    end
    it 'should return false if input less than 4 chars' do
      input = 'rbg'
      expect(new_game.valid_input?(input)).to be false
    end
    it 'should return false if input isn\'t r, g, b or y' do
      input = 'x@g'
      expect(new_game.valid_input?(input)).to be false
    end
  end

  describe '#code_broke?' do
    it 'should return Boolean value if user break the code' do
      code = new_game.board.code_maker_board
      expect(new_game.code_broke?(input)).to eq(input == code)
    end
  end

  describe '#store_code' do
    it 'should store user input in Board#code_breaker_board' do
      expect(new_game.store_code(input, 0)).to eq(new_game.board.code_breaker_board[0])
    end
  end

  describe '#feedback' do
    it 'should return a feedback array built on the user input' do
      input = %w[r g b y]
      expect(new_game.feedback(input)).to be_an Array
    end
  end
end
