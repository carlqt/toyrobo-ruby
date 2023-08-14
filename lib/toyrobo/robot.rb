# frozen_string_literal: true

require_relative "robots/location_out_of_bounds_error"

module Toyrobo
  # Robot class represents a robot object. The robot object can move and spawn on the plane
  class Robot
    ORIENTATIONS = %i[north east south west].freeze

    ORIENTATION_RANGES = {
      north: 1,
      east: 1,
      south: -1,
      west: -1
    }.freeze

    COUNTER_CLOCKWISE = -1
    CLOCKWISE = 1

    attr_reader :orientation, :x_position, :y_position

    private_constant :COUNTER_CLOCKWISE, :CLOCKWISE

    # Plane = cartesian_plane like object
    # Any structure the has a "get" function
    def initialize(plane = Toyrobo::Table.new)
      @plane = plane
      @orientation = :north
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

    def place(x_coor, y_coor, direction)
      raise Robots::LocationOutOfBoundsError if @plane.get(x_coor, y_coor).nil?

      @x_position = x_coor
      @y_position = y_coor
      @orientation = direction

      current_position
    end

    def report
      "OUTPUT: #{@x_position},#{@y_position},#{orientation.upcase}"
    end

    # Orientation Ranges
    def move
      range = ORIENTATION_RANGES[orientation]

      case orientation
      when :north, :south
        place(x_position, y_position + range, orientation)
      when :east, :west
        place(x_position + range, y_position, orientation)
      else
        raise Robots::LocationOutOfBoundsError
      end
    end

    def left
      turn(COUNTER_CLOCKWISE)
    end

    def right
      turn(CLOCKWISE)
    end

    private

    def turn(numeric_direction)
      current_index = ORIENTATIONS.index(orientation) # : Integer

      new_index = (current_index + numeric_direction) % ORIENTATIONS.size
      self.orientation = ORIENTATIONS[new_index]
    end

    def orientation=(val)
      @orientation = val

      current_position
    end
  end
end
