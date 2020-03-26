class Ennemy
  attr_accessor :x, :y, :width, :height, :speed
  def initialize(x, y)
    @x = x
    @y = y
    @width = 60
    @height = 60
    @image = Gosu::Image.new("assets/ennemy.png")
    prng = Random.new
    @direction = prng.rand(0..360)
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

  def draw(camera_x, camera_y)
    x = @x + @width / 2 - camera_x
    y = @y + @height / 2 - camera_y
    @image.draw_rot(x, y, 0, 180 + @direction)
  end
end
