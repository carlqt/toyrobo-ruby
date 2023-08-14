# frozen_string_literal: true

module Toyrobo
  # The Table class is a representation of a cartesian plane
  # (0, 0) is the leftmost corner of the plane .e.g of a 3x3 plane
  # [[][][][][]]
  # [[][][][][]]
  # [[0,0][][][][]]
  class Table
    attr_reader :store

    def initialize(height = 5, width = 5)
      row = Array.new(width) { 0 }
      @store = Array.new(height) { row }
    end

    # Only Positive integers
    def get(x_coor, y_coor)
      inner_index = x_coor
      outer_index = (@store.length - 1) - y_coor

      return if [inner_index, outer_index].any?(&:negative?)

      @store.dig(outer_index, inner_index)
    end
  end
end
