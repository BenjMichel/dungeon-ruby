class Player
  attr_accessor :x, :y, :width, :height
  def initialize(x = 10, y = 10)
    @x = x
    @y = y
    @width = 60
    @height = 60
    @image_player = Gosu::Image.new("assets/starfighter.bmp")
    @direction = 90
  end

  def update_position(x, y)
    delta_x = x - @x
    delta_y = y - @y
    @x = x
    @y = y
    if (delta_x != 0 or delta_y != 0)
      @direction = Math.atan2(delta_x, -delta_y) * 180 / Math::PI
    end
  end

  def draw(window_width, window_height)
    @image_player.draw_rot((@width + window_width) / 2, (@height + window_height) / 2, 0, @direction)
  end
end
