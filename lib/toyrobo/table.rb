# frozen_string_literal: true

module Toyrobo
  # The Table class is a representation of a cartesian plane
  # (0, 0) is the leftmost corner of the plane .e.g of a 3x3 plane
  # [[][][][][]]
  # [[][][][][]]
  # [[0,0][][][][]]
  class Table
    attr_reader :height, :width

    def initialize(height = 5, width = 5, obstacle = [])
      @height = (0..height)
      @width = (0..width)
      @obstacle = obstacle
    end

    # Only Positive integers
    def get(x_coor, y_coor)
      # If the coords parameters are within the dimensions
      # but the coords hit an obstacle then return nil

      # else 0

      if [height.cover?(y_coor), width.cover?(x_coor)].all?
        return nil if obstructed?(x_coor, y_coor)

        return 0
        # if not in an obstacle? return 0
      end
    end

    def obstructed?(x_coor, y_coor)
      @obstacle.find do |points|
        points[0] == x_coor && points[1] == y_coor
      end
    end
  end
end
