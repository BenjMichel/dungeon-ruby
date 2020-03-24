require_relative "procedural"

include Procedural

module Game_module
  class Game
    def initialize()
      @map = Map.new(60, 30)
      @map.generate
      @map.render
    end

    def render
      @map.render
    end

    def draw(camera_x, camera_y)
      @map.draw(camera_x, camera_y)
    end
  end
end
