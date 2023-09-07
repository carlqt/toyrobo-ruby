require "pry"

class Token
  attr_reader :type, :value

  TOKEN_TYPES = {
    operator: :operator,
    num: :num
  }.freeze

  def initialize(val, type)
    @type = type
    @value = val
  end

  # Returns a list of tokens
  def self.tokenize(stmnt)
    tokens = []

    stmnt.chars.each do |c|
      next if c == " "

      tokens << if c == "+" || c == "*"
                  Token.new(c, :operator)
                else
                  Token.new(c, :num)
                end
    end

    tokens
  end
end

class Node
  attr_accessor :left, :right, :value, :type

  TOKEN_TYPES = {
    operator: :operator,
    num: :num
  }.freeze

  def initialize(val, type, l = nil, r = nil)
    @value = val
    @type = type
    @left = l
    @right = r
  end

  def print
    return value if type == TOKEN_TYPES[:num]

    left_node = left.print
    right_node = right.print

    "(#{left_node} #{value} #{right_node})"
  end

  def self.parse(tokens)
    nodes = nil
    list = tokens.dup
  end
end

class Parse
  attr_reader :nodes

  def initialize(tokens)
    @tokens = tokens.dup
    @pointer = 0
    @nodes = []
  end

  # E -> T + E | T - E | T
  # T -> F * T | F / T | F
  # F -> ID | INTEGER | (E) | -F

  # With type precedence
  # E -> T{+|- T}*
  # T -> F * T | F / T | F
  def expr
    a = term

    loop do
      # + 5
      if current&.value == "+"
        a = Node.new(scan_current.value, :operator, a, term)
      else
        return a
      end
    end
  end

  def term
    if next_token&.value == "*"
      left_node = Node.new(scan_current.value, :num)
      op = Node.new(scan_current.value, :operator)
      op.left = left_node
      op.right = term

      return op
    end

    Node.new(scan_current.value, :num)
  end

  def pending_tokens?
    !@tokens.empty?
  end

  def current
    @tokens[0]
  end

  def next_token
    @tokens[1]
  end

  # Scan gets and shifts the array by 1
  def scan_current
    @tokens.shift
  end
end

def reader(current_node)
  left = current_node.left ? reader(current_node.left) : nil
  right = current_node.right ? reader(current_node.right) : nil

  "#{left} #{current_node.value} #{right}"
end

# e.g. 1 + 2 + 3

# E -> T + E | T - E | T
# T -> F * T | F / T | F
# F -> ID | INTEGER | (E) | -F

str = "1+3*5+7*9"
tokens = Token.tokenize(str)
noods = Parse.new(tokens).expr

# res = reader(noods)

# binding.pry

puts noods.print
# {
#   "type": "operator",
#   "val": "+",
#   "left": {
#     "type": "operator",
#     "val": "+",
#     "left": {
#       "type": "operator",
#       "val": "+",
#       "left": {
#         "type": "num",
#         "val": 1
#       },
#       "right": {
#         "type": "num",
#         "val": 2
#       }
#     },
#     "right": {
#       "type": "num",
#       "val": 3
#     }
#   },
#   "right": {
#     "type": "num",
#     "val": 4
#   }
# }
