require 'gosu'
require_relative 'game'

include Game_module

class GameWindow < Gosu::Window
  def initialize(width=640, height=480, fullscreen=false)
    super
    @game = Game.new
    self.caption = 'Hello Movement'
    @image_player = Gosu::Image.new("assets/starfighter.bmp")
    @x = @y = 10
    @draws = 0
    @buttons_down = 0
    @window_width = width
    @window_height = height
  end

  def update
    speed = 3
    @x -= speed if button_down?(Gosu::KbLeft)
    @x += speed if button_down?(Gosu::KbRight)
    @y -= speed if button_down?(Gosu::KbUp)
    @y += speed if button_down?(Gosu::KbDown)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @buttons_down += 1
  end

  def button_up(id)
    @buttons_down -= 1
  end

  def needs_redraw?
    @draws == 0 || @buttons_down > 0
  end

  def draw
    @game.draw(@x, @y, @window_width, @window_height)
    @image_player.draw(@window_width / 2, @window_height / 2, 0)
  end

  private

  def info
    "[x:#{@x};y:#{@y};draws:#{@draws}]"
  end
end

window = GameWindow.new
window.show
