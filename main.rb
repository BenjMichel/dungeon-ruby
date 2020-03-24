require_relative "game"

include Game_module

class Main
  def initialize()
    @game = Game.new
    framerate = 60.0
    @seconds_between_updates = 1.0 / framerate
  end

  def start
    while true
      start = Time.now

      @game.render

      finish = Time.now
      sleep_time = start - finish + @seconds_between_updates
      sleep [sleep_time, 0].max
    end
  end
end

main = Main.new
main.start
