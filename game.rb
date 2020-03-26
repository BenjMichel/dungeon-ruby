require_relative 'procedural'
require_relative 'player'
require_relative 'bullet'

class Game
  def initialize
    @map = Map.new(40, 40)
    @map.generate
    x, y = @map.start_player_position
    @player = Player.new(x, y)
    @bullets = []
  end

  def check_collision_with_map(x1, y1, x2, y2)
    return (
      @map.check_collision(x1, y1) or
      @map.check_collision(x1, y2) or
      @map.check_collision(x2, y1) or
      @map.check_collision(x2, y2)
    )
  end

  def get_new_position(ids, speed)
    new_x = @player.x
    new_y = @player.y
    new_x -= speed if ids.include?(Gosu::KbLeft)
    new_x += speed if ids.include?(Gosu::KbRight)
    new_y -= speed if ids.include?(Gosu::KbUp)
    new_y += speed if ids.include?(Gosu::KbDown)
    return new_x, new_y
  end

  def update_move(ids)
    speed = @player.speed
    new_x, new_y = get_new_position(ids, speed)
    new_x2, new_y2 = get_new_position(ids, speed / 2)

    if not check_collision_with_map(new_x, new_y, new_x + @player.width, new_y + @player.height)
      @player.update_position(new_x, new_y)
    elsif not check_collision_with_map(new_x2, new_y2, new_x2 + @player.width, new_y2 + @player.height)
      @player.update_position(new_x2, new_y2)
    else
      shouldUpdateOnlyDirection = true
      @player.update_position(new_x, new_y, shouldUpdateOnlyDirection)
    end
  end

  def trigger_fire(ids)
    if ids.include?(Gosu::KbSpace) and @player.cool_down == 0
      @bullets.push(Bullet.new(@player))
      @player.cool_down = @player.default_cool_down
    end
  end

  def update
    @bullets.each { |bullet| bullet.update_position }
    @bullets = @bullets.reject {|bullet| @map.check_collision(bullet.x, bullet.y) }
    @player.update
  end

  def button_down(ids)
    update_move(ids)
    trigger_fire(ids)
  end

  def render
    @map.render
  end

  def draw(window_width, window_height)
    camera_x = @player.x - window_width / 2
    camera_y = @player.y - window_height / 2
    @map.draw_tiles(camera_x, camera_y, window_width, window_height)
    @map.draw_ennemies(camera_x, camera_y)
    @player.draw(window_width, window_height)
    @bullets.each { |bullet| bullet.draw(camera_x, camera_y)  }
  end
end
