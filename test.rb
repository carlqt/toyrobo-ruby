# Lexer

require 'pry'

class Lexer
  attr_reader :tokens

  "Input string is a blob of text"
  def initialize(input_string)
    @input = input_string
    @big_input = input_string.split("\n")
    @tokens = []
  end

  # Super simple Parser/Lexer
  def tokenize
    command, args = @input.split(" ")

    # ELSE raise exception
    if Token::COMMANDS.include?(command&.downcase)
      token = Token.new(:command, command)
    end

    unless args.nil?
      # maybe coerce the type here too?
      token.args = args.split(",")
    end

    @tokens << token
  end
end

class Token
  COMMANDS = %w[place move left right report]

  attr_accessor :type, :text, :args

  def initialize(type = nil, text = nil, position = nil)
    @type = type
    @text = text
    @position = position
  end
end

l = Lexer.new('PLACE 1,3,north')
l.tokenize

puts "output"
puts l.tokens.inspect

class Interpreter
  def initialize(tokens)
    @tokens = tokens
    @robot = robot
  end

  def run
    tokens.each do |t|
      case t.text
      when :place
        @robot.place(*t.args)
    end
  end
end

# AST:
=begin

{
  [
    {
      type: :command
      val: :place
      args: [
        {
          type: :number
          val: 1
        },
        {
          type: :number
          val: 2
        },
        {
          type: :string
          val: :north
        },
      ]
    },
    {
      type: :command
      val: :move
    }
  ]
}

=end

# Tokens -> PLACE 1,2,NORTH
# Token(:command, text: 'place')
# Token(:num, text: 1)
# Token(:separator, text: ',')
# Token(:num, text: 1)
# Token(:separator, text: ',')
# Token(:string, text: 'NORTH')

# rules
# command -> command
# command -> command arg1 arg2 arg3
# Interpreter.run(tokens, robot)

# Check if instruction is valid or not
# Acts as a lexer and parser due to simplicity of commands
# class CommandParser
#   def initialize(input)
#   end

#   def run
#     input.each do |i|
#       commands << command_parser(i)
#   end

# command_map = {
#   place: Place,
#   move: Move
# }

#  def command_parser(input)
#   cmd, args = input.split
#   command = command_map.fetch(cmd) { nil }
#   command.new(robot, args)
# end

# Interpreter(command_tree)
#   def run
#     commands = []
#     file.each_line do |f|
#     commands << command_parser(f)

# command_map = {
#   place: Place,
#   move: Move
# }

#  def command_parser(input)
#   cmd, args = input.split
#   command = command_map.fetch(cmd) { nil }
#   command.new(robot, args)
