module Toyrobo
  class Robot
    ORIENTATIONS = {
      north: :north,
      south: :south,
      east: :east,
      west: :west
    }.freeze

    attr_reader :orientation

    # Plane = cartesian_plane like object
    def initialize(plane)
      @plane = plane
      @orientation = :north
      @x_position = 0
      @y_position = 0
    end

    def orientation=(val)
      if ORIENTATIONS[val].nil?
        raise 'Unknown orientation'
      end

      @orientation = ORIENTATIONS[val]
    end

    def place(x,y,direction)
    end
  end
end
