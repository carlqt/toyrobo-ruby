=begin
   x   x x x x
y [4,0][][][][]
y [3,0][][][][]
y [2,0][][][][]
y [1,0][][][][]
y [0,0][][][][]
=end

# cartesian plane style
class Table
  class TableIndexException < StandardError; end

  attr_reader :store

  def initialize(height, width)
    row = Array.new(width) { 0 }
    @store = Array.new(height) { row }
  end

  # Only Positive integers
  def get(x_coor, y_coor)
    inner_index = x_coor
    outer_index = (@store.length - 1) - y_coor

    # validation:
    # raise error if either inner_index or outer_index is negative
    # error if inner_index and outer_index are out_of_bounds (returns nil?)
    if [inner_index, outer_index].any?(&:negative?)
      raise Table::TableIndexException.new("Negative index outside of array bounds") 
    end

    # @store[outer_index][inner_index]
    @store.fetch(outer_index).fetch(inner_index)
    # 0,0 = [4][0]
    # 3,1 = [3][3]
    # 2,1 = [3][2]
    # 4,3 = [1][4]

    # x -> 2nd/inner index
    # y -> (length - 1) - y
  rescue IndexError, TableIndexException
    nil
  end
end
