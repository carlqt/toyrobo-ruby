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
  def initialize(height, width)
    row = Array.new(width) { 0 }
    @store = Array.new(height) { row }
  end

  # Only Positive integers
  def get(x, y)
    # 0,0 = [4][0]
    # 3,1 = [3][3]
    # 2,1 = [3][2]
    # 4,3 = [1][4]

    # x -> 2nd/inner index
    # y -> (length - 1) - y
  end
end
