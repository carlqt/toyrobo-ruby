# frozen_string_literal: true

require "toyrobo/table"
require "toyrobo/robot"
require "toyrobo/command_parser"

=begin
class CommandParser
  def initialize(input)
    @input = input.gsub(","," ").split
  end

  def name
    @input[0].downcase.to_sym
  end

  def args
    @input[1..-1]
  end
end

simulator class takes the command

class Simulator
  def initialize
    @table = table
    @robot = robot
  end

  def run(input)
    command = CommandParser.new(input)

    case command.name
    when 
  end
end

=end

module Toyrobo
  module Ruby
    class Error < StandardError; end

    # initialize the robot?
    class Runner
      def initialize
        filename = 'input.txt'
        @file = File.open(filename)
      end

      def run
        # loop through each line of file
        # parse to get the command
        tokens = []
        File.foreach(@file) do |f|
          command_parser = Toyrobo::CommandParser.new(f)
          tokens << command_parser.tokens
        end
      end
    end
  end
end
