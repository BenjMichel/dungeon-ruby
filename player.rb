class Player
  attr_accessor :x, :y, :width, :height
  def initialize(x = 10, y = 10)
    @x = x
    @y = y
    @width = 60
    @height = 60
    @image_player = Gosu::Image.new("assets/starfighter.bmp")
  end

  def draw(window_width, window_height)
    @image_player.draw(window_width / 2, window_height / 2, 0)
  end
end
