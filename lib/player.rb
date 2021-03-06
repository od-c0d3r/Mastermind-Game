# frozen_string_literal: true

class Player
  attr_reader :name

  def initialize(name, type = nil)
    @name = name
    @type = type
  end
end
