class Ennemy
  attr_accessor :x, :y, :width, :height, :direction, :speed, :default_cool_down, :cool_down
  def initialize(x, y)
    @x = x
    @y = y
    @width = 40
    @height = 40
    @image = Gosu::Image.new("assets/officer.png")
    prng = Random.new
    @direction = prng.rand(0..360)
    @speed = 3
    @life = 2
    @cool_down = 0
    @default_cool_down = 20
    @distance_min = 80
    @distance_can_see = 400
  end

  def can_shoot
    @cool_down <= 0
  end

  def is_alive
    @life > 0
  end

  def remove_life(nb_life)
    @life -= nb_life
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

  def distance_from player
    Math.sqrt((player.x - @x) ** 2 + (player.y - @y) ** 2)
  end

  def move_toward player
    distance = distance_from player
    if (distance >= @distance_min and distance <= @distance_can_see)
      delta_x = @x + (player.x - @x) / distance * @speed
      delta_y = @y + (player.y - @y) / distance * @speed
      update_position(delta_x, delta_y)
    end
  end

  def can_see player
    distance_from(player) <= @distance_can_see
  end

  def update
    @cool_down -= 1 if @cool_down > 0
  end

  def draw(camera_x, camera_y)
    x = @x + @width / 2 - camera_x
    y = @y + @height / 2 - camera_y
    @image.draw_rot(x, y, 0, 180 + @direction)
  end
end
