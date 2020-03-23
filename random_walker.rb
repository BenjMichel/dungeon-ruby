class Map
  def initialize(width = 10, height = 10)
    @game_map = Array.new(width) {Array.new(height, 0)}
  end

  def width
    @game_map.length
  end

  def height
    @game_map[0].length
  end

  def game_map
    @game_map
  end

  def generate
    width = self.width
    height = self.height
    x = width / 2
    y = height / 2
    @game_map[x][y] = 1
    area = width * height
    nbTilesMax = area / 2 # arbitrary ratio 50% of the total tiles
    prng = Random.new
    nbTilesMax.times {
      direction = prng.rand(4)
      case direction
      when 0 then x = [0, x - 1].max
      when 1 then y = [height - 1, y + 1].min
      when 2 then x = [width - 1, x + 1].min
      when 3 then y = [0, y - 1].max
      end
      @game_map[x][y] = 1
    }
  end
end

map1 = Map.new(20, 30)

map1.generate
map1.game_map.each do |row|
  if row.nil?
    puts "..."
  elsif row.respond_to?("each")
    p row
  end
end
