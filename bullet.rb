class Bullet
  attr_accessor :x, :y, :width, :height, :speed, :to_delete, :damage, :owner
  def initialize(player)
    @width = 20
    @height = 20
    @speed = 10
    directionRad = player.direction * Math::PI / 180
    @vx = @speed * Math.sin(directionRad)
    @vy = @speed * -Math.cos(directionRad)
    @x = player.x - @width / 2 + player.width / 2 + @vx
    @y = player.y - @height / 2 + player.height / 2 + @vy
    @image = Gosu::Image.new("assets/bullet.png")
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
