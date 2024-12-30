# frozen_string_literal: true

module Toyrobo
  # The Table class is a representation of a cartesian plane
  # (0, 0) is the leftmost corner of the plane .e.g of a 3x3 plane
  # [[][][][][]]
  # [[][][][][]]
  # [[0,0][][][][]]
  class Table
    attr_reader :height, :width

    def initialize(height = 5, width = 5)
      @height = (0..height)
      @width = (0..width)
    end

    # Only Positive integers
    def get(x_coor, y_coor)
      0 if [height.cover?(y_coor), width.cover?(x_coor)].all?
    end
  end
end
