# frozen_string_literal: true

require_relative "robots/location_out_of_bounds_error"
require_relative "breadth_first_search"

class TreeNode
  attr_accessor :x_position, :y_position

  def initialize(x_position, y_position)
    @x_position = x_position
    @y_position = y_position
  end

  def equal?(other)
    other.x_position == x_position && other.y_position == y_position
  end

  # []
  def adjacents
    a = [
      up,
      down,
      left,
      right
    ].compact

    binding.pry if y_position == 5 && x_position == 5

    a.empty? ? [] : a
  end

  def up
    return nil unless (0..3).cover?(y_position + 1)

    @up ||= TreeNode.new(x_position, y_position + 1)
  end

  def down
    return nil unless (0..5).cover?(y_position - 1)

    @down ||= TreeNode.new(x_position, y_position - 1)
  end

  def left
    return nil unless (0..5).cover?(x_position - 1)

    @left ||= TreeNode.new(x_position - 1, y_position)
  end

  def right
    return nil unless (0..5).cover?(x_position + 1)

    @right ||= TreeNode.new(x_position + 1, y_position)
  end
end


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

    def goal(x_coor, y_coor)
      root = TreeNode.new(x_position, y_position)

      # Takes too long to initialize
      bfs = BreadthFirstSearch.new({}, root)
      # Returns a set of points/path the robot will take Avoid colliding with an obstacle
      # Current point -> 0,0
      # End point -> 2,2
      # Paths -> 0,1 - 0, 2 - 1,2 - 2,2
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
      @current_position[:orientation] = ORIENTATIONS[new_index]
    end
  end
end
