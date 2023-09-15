# frozen_string_literal: true

require_relative "robots/location_out_of_bounds_error"
require_relative "breadth_first_search"

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

    private_constant :COUNTER_CLOCKWISE, :CLOCKWISE

    attr_reader :current_position

    # Plane = cartesian_plane like object
    # Any structure the has a "get" function
    def initialize(plane = Toyrobo::Table.new)
      @plane = plane
      @current_position = {
        x_position: 0,
        y_position: 0,
        orientation: :north
      }
    end

    def orientation
      current_position[:orientation]
    end

    def x_position
      current_position[:x_position]
    end

    def y_position
      current_position[:y_position]
    end

    def place(x_coor, y_coor, direction)
      raise Robots::LocationOutOfBoundsError if @plane.get(x_coor, y_coor).nil?

      @current_position[:x_position] = x_coor
      @current_position[:y_position] = y_coor
      @current_position[:orientation] = direction

      current_position
    end

    def report
      "OUTPUT: #{x_position},#{y_position},#{orientation.upcase}"
    end

    # Returns the all the coordinates that were visited to get to the target
    def goal(x_coor, y_coor)
      start = [x_position, y_position]
      target = [x_coor, y_coor]

      # Converting the set to an array
      paths = Toyrobo::BFS.start(@plane, start, target)

      puts trace_paths(paths, [x_coor, y_coor]).inspect
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

    def trace_paths(paths, start)
      # paths -> Hash[[Integer, Integer], [Integer, Integer]]
      s = start.dup
      result = [s]

      until paths[s].nil?
        s = paths[s].first
        result << s
      end

      result.reverse
    end

    def turn(numeric_direction)
      current_index = ORIENTATIONS.index(orientation) # : Integer

      new_index = (current_index + numeric_direction) % ORIENTATIONS.size
      @current_position[:orientation] = ORIENTATIONS[new_index]
    end
  end
end
