require_relative "procedural"

include Procedural

module Game_module
  class Game
    def initialize()
      @map = Map.new(60, 30)
      @map.generate
    end

    def render
      @map.render
    end
  end
end
