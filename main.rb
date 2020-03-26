require 'gosu'
require_relative 'game'

class GameWindow < Gosu::Window
  def initialize(width=1280, height=960, fullscreen=false)
    super
    @game = Game.new
    self.caption = 'Hello'
    @draws = 0
    @buttons_down = 0
    @window_width = width
    @window_height = height
  end

  def update
    ids = []
    ids.push(Gosu::KbLeft) if button_down?(Gosu::KbLeft)
    ids.push(Gosu::KbRight) if button_down?(Gosu::KbRight)
    ids.push(Gosu::KbUp) if button_down?(Gosu::KbUp)
    ids.push(Gosu::KbDown) if button_down?(Gosu::KbDown)
    ids.push(Gosu::KbDown) if button_down?(Gosu::KbDown)
    ids.push(Gosu::KbSpace) if button_down?(Gosu::KbSpace)
    @game.button_down(ids)
    @game.update
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
    @game.draw(@window_width, @window_height)
  end

  private

  def info
    "[x:#{@x};y:#{@y};draws:#{@draws}]"
  end
end

window = GameWindow.new
window.show
