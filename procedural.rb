module Procedural
  class Room
    attr_accessor :width, :height, :x, :y
    def initialize(minSize, maxSize)
      prng = Random.new
      @width = prng.rand(minSize..maxSize)
      @height = prng.rand(minSize..maxSize)
    end

    def get_random_point
      prng = Random.new
      {
        "x" => prng.rand(@x..@x + @width),
        "y" => prng.rand(@y..@y + @height),
      }
    end
  end

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

    def rooms_to_game_map(rooms)
      rooms.each do |room|
        (room.x..room.x + room.width).each do |x|
          (room.y..room.y + room.height).each do |y|
            @game_map[x][y] = 1
          end
        end
      end
    end

    def draw_corridor(pointA, pointB)
      xA = pointA["x"]
      yA = pointA["y"]
      xB = pointB["x"]
      yB = pointB["y"]

      minY = [yA, yB].min
      maxY = [yA, yB].max
      minX = [xA, xB].min
      maxX = [xA, xB].max

      (minY..maxY).each do |y|
        @game_map[xA][y] = 1
      end
      (minX..maxX).each do |x|
        @game_map[x][yB] = 1
      end
    end

    def generate_corridors(rooms)
      rooms.each_with_index do |roomA, index|
        rooms[index+1..rooms.length].each do |roomB|
          pointA = roomA.get_random_point
          pointB = roomB.get_random_point
          draw_corridor(pointA, pointB)
        end
      end
    end

    def generate
      width = self.width
      height = self.height
      area = width * height
      nbRooms = area / 200
      roomMinSize = 3
      roomMaxSize = 8
      rooms = []
      prng = Random.new
      nbRooms.times {
        room = Room.new(roomMinSize, roomMaxSize)
        rooms.push(room)
        room.x = prng.rand(0..width - room.width - 1)
        room.y = prng.rand(0..height - room.height - 1)
      }
      rooms_to_game_map(rooms)
      generate_corridors(rooms)
    end

    def render
      @game_map.each do |row|
        if row.nil?
          puts "..."
        elsif row.respond_to?("each")
          p row
        end
      end
    end
  end
end
