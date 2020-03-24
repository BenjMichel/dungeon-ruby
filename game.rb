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

    def draw(camera_x, camera_y, window_width, window_height)
      @map.draw(camera_x, camera_y, window_width, window_height)
    end
  end
end
