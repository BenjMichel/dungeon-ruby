require_relative "procedural"
require_relative "player"

class Game
  def initialize()
    @map = Map.new(40, 40)
    @map.generate
    @map.render
    x = @map.start_player_position["x"]
    y = @map.start_player_position["y"]
    @player = Player.new(x, y)
  end

  def check_collision_with_map(x1, y1, x2, y2)
    return (
      @map.check_collision(x1, y1) or
      @map.check_collision(x1, y2) or
      @map.check_collision(x2, y1) or
      @map.check_collision(x2, y2)
    )
  end

  def button_down(id)
    speed = 3
    new_x = @player.x
    new_y = @player.y
    new_x -= speed if id == Gosu::KbLeft
    new_x += speed if id == Gosu::KbRight
    new_y -= speed if id == Gosu::KbUp
    new_y += speed if id == Gosu::KbDown
    if not check_collision_with_map(new_x, new_y, new_x + @player.width, new_y + @player.height)
      @player.x = new_x
      @player.y = new_y
    end
  end

  def render
    @map.render
  end

  def draw(window_width, window_height)
    camera_x = @player.x - window_width / 2
    camera_y = @player.y - window_height / 2
    @map.draw(camera_x, camera_y, window_width, window_height)
    @player.draw(window_width, window_height)
  end
end
