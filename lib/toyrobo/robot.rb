# frozen_string_literal: true

module Toyrobo
  class Robot
    ORIENTATIONS = %w[north east south west].freeze

    ORIENTATION_RANGES = {
      "north" => 1,
      "east" => 1,
      "south" => -1,
      "west" => -1
    }.freeze

    attr_reader :orientation

    # Plane = cartesian_plane like object
    # raise exception if @plane.get(0, 0) is nil?
    def initialize(plane)
      @plane = plane
      @orientation = "north"

      raise "Invalid Table" if @plane.get(0, 0).nil?

      @x_position = 0
      @y_position = 0
    end

    def current_position
      {
        x_position: @x_position,
        y_position: @y_position,
        orientation:
      }
    end

    # val is :east
    def orientation=(val)
      if ORIENTATIONS.index(val).nil?
        raise 'Unknown orientation'
      end

      @orientation = val

      current_position
    end

    def place(x_coor, y_coor, direction)
      raise 'Invalid placement' if @plane.get(x_coor, y_coor).nil?

      # validation if direction isn't correct value

      @x_position = x_coor
      @y_position = y_coor
      @orientation = direction.downcase

      current_position
    end

    def robot
      "OUTPUT: #{@x_position}, #{@y_position}, #{orientation}"
    end

    # Orientation Ranges
    def move
      range = ORIENTATION_RANGES[orientation]

      case orientation
      when "north", "south"
        place(@x_position, @y_position + range, orientation)
      when "east", "west"
        place(@x_position, @y_position + range, orientation)
      else
        raise "Unkown Movement"
      end
    end

    # north -> west -> south -> east
    def left
      turn(-1)
    end

    # north -> east -> south -> west
    def right
      turn(1)
    end

    def turn(numeric_direction)
      current_index = ORIENTATIONS.index(orientation)

      raise "Unknown orientation" if current_index.nil?

      new_index = (current_index + numeric_direction) % ORIENTATIONS.size
      self.orientation = ORIENTATIONS[new_index]
    end
  end
end
