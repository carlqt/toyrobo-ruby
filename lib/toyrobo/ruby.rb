# frozen_string_literal: true

require "toyrobo/table"
require "toyrobo/robot"
require "toyrobo/lexer"
require "toyrobo/parser"

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

# TODO: Figure out "A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands."

module Toyrobo
  module Ruby
    class Error < StandardError; end

    # initialize the robot?
    class Runner
      def initialize
        filename = "input.txt"
        table = Toyrobo::Table.new(5, 5)
        @robot = Toyrobo::Robot.new(table)
        @file = File.open(filename)
      end

      def run
        # loop through each line of file
        # parse to get the command
        tokens = []
        File.foreach(@file) do |f|
          command_parser = Toyrobo::Lexer.new(f)
          tokens << command_parser.tokens
        end

        parser = Toyrobo::Parser.new(tokens.flatten)
        parser.run

        Interpreter.new(parser.nodes, @robot).run
      end
    end

    class Interpreter
      def initialize(command_nodes, robot)
        @commands = command_nodes
        @robot = robot
      end

      # Logic
      # - Ignore command if Place is not the first command
      # - Ignore command if there is exception
      # - 
      def run
        @commands.each do |c|
          if c.params.empty?
            if c.value == "report"
              puts @robot.send(c.value)
            else
              @robot.send(c.value)
            end
          else
            @robot.send(c.value, *format_params(c.params))
          end
          # if c is command
          # if c.params.empty?
          # @robot.send(c)
          # else
          # @robot.send(c, *format_params(c.params))
        end
      end

      def report
        puts @robot.report
      end

      def format_params(params)
        params.map do |param|
          if param.type == :num
            param.value.to_i
          else param.type == :string
            param.value.downcase.to_sym
          end
        end
      end
    end
  end
end
