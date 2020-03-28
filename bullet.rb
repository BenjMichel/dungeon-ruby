class Bullet
  attr_accessor :x, :y, :width, :height, :speed, :to_delete, :damage
  def initialize(player)
    @x = player.x + player.width / 2
    @y = player.y + player.height / 2
    @width = 20
    @height = 20
    @image = Gosu::Image.new("assets/bullet.png")
    @speed = 10
    directionRad = player.direction * Math::PI / 180
    @vx = @speed * Math.sin(directionRad)
    @vy = -@speed * Math.cos(directionRad)
    @owner = player
    @to_delete = false
    @damage = 1
  end

  def update_position
    @x += @vx
    @y += @vy
  end

  def draw(camera_x, camera_y)
    x = @x - camera_x
    y = @y - camera_y
    @image.draw(x, y, 0)
  end
end
