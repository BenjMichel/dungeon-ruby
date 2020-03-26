class Player
  attr_accessor :x, :y, :width, :height, :speed, :direction
  def initialize(x = 10, y = 10)
    @x = x
    @y = y
    @width = 60
    @height = 60
    @image = Gosu::Image.new("assets/player.png")
    @direction = 90
    @speed = 3
  end

  def update_position(x, y, shouldUpdateOnlyDirection = false)
    delta_x = x - @x
    delta_y = y - @y
    if not shouldUpdateOnlyDirection
      @x = x
      @y = y
    end
    if (delta_x != 0 or delta_y != 0)
      @direction = Math.atan2(delta_x, -delta_y) * 180 / Math::PI
    end
  end

  def draw(window_width, window_height)
    @image.draw_rot((@width + window_width) / 2, (@height + window_height) / 2, 0, 180 + @direction)
  end
end
