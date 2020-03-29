require 'gosu'
require_relative 'ennemy'

TILE_SIZE = 64
GRASS = 0
WALL = 1

class Room
  attr_accessor :width, :height, :x, :y
  def initialize(minSize, maxSize)
    prng = Random.new
    @width = prng.rand(minSize..maxSize)
    @height = prng.rand(minSize..maxSize)
  end

  def get_random_point
    prng = Random.new
    return prng.rand(@x..@x + @width), prng.rand(@y..@y + @height)
  end
end



class Map
  attr_accessor :start_player_position, :ennemies
  def initialize(width, height)
    @game_map = Array.new(width) {Array.new(height, WALL)}
    @image_wall = Gosu::Image.new("assets/wall.png")
    @image_grass = Gosu::Image.new("assets/floor.png")
    @ennemies = []
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
          @game_map[x][y] = GRASS
        end
      end
    end
  end

  def draw_corridor(pointA, pointB)
    xA, yA = pointA
    xB, yB = pointB

    minY = [yA, yB].min
    maxY = [yA, yB].max
    minX = [xA, xB].min
    maxX = [xA, xB].max

    # return if (maxY - minY > 12 or maxX - minX > 12)

    (minY..maxY).each do |y|
      @game_map[xA][y] = GRASS
    end
    (minX..maxX).each do |x|
      @game_map[x][yB] = GRASS
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

  def get_random_starting_point(room)
    x, y = room.get_random_point
    return x * TILE_SIZE, y * TILE_SIZE
  end

  def add_ennemies(room)
    prng = Random.new
    nb_ennemies = prng.rand(0..4)
    nb_ennemies.times {
      x, y = room.get_random_point
      @ennemies.push(Ennemy.new(x * TILE_SIZE, y * TILE_SIZE))
    }
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
      room.x = prng.rand(0..width - room.width - 1)
      room.y = prng.rand(0..height - room.height - 1)
      add_ennemies(room) if @start_player_position
      @start_player_position = get_random_starting_point(room) if not @start_player_position
      rooms.push(room)
    }
    rooms_to_game_map(rooms)
    generate_corridors(rooms)
  end

  def check_collision(x, y)
    tile_x = x / TILE_SIZE
    tile_y = y / TILE_SIZE
    return true if tile_x < 0
    return true if tile_y < 0
    return true if tile_x >= width
    return true if tile_y >= height
    not @game_map[tile_x][tile_y] == GRASS
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

  def draw_tiles(camera_x, camera_y, window_width, window_height)
    if (height > 0 and width > 0)
      height.times do |y|
        width.times do |x|
          tile = @game_map[x][y] == WALL ? @image_wall : @image_grass
          position_x = -camera_x + x * TILE_SIZE
          position_y = -camera_y + y * TILE_SIZE
          next if (
            position_x < -TILE_SIZE or
            position_y < -TILE_SIZE or
            position_x >= window_width or
            position_y >= window_height)
          tile.draw(position_x, position_y, 0)
        end
      end
    end
  end

  def draw_ennemies(camera_x, camera_y)
    @ennemies
      .filter { |ennemy| ennemy.is_alive }
      .each { |ennemy| ennemy.draw(camera_x, camera_y) }
  end
end
