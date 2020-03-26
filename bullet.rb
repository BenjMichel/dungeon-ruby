class Bullet
  attr_accessor :x, :y, :width, :height, :speed
  def initialize(player)
    @x = player.x
    @y = player.y
    @width = 20
    @height = 20
    @image = Gosu::Image.new("assets/bullet.png")
    @speed = 10
    directionRad = player.direction * Math::PI / 180
    @vx = @speed * Math.sin(directionRad)
    @vy = -@speed * Math.cos(directionRad)
    @owner = player
  end

  def update_position
    @x += @vx
    @y += @vy
  end

  def draw(camera_x, camera_y)
    x = @x + @width / 2 - camera_x
    y = @y + @height / 2 - camera_y
    @image.draw(x, y, 0)
  end
end
