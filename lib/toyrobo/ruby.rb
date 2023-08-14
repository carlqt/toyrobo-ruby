# frozen_string_literal: true

require "toyrobo/table"
require "toyrobo/robot"
require "toyrobo/command_parser"
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

        # Interpreter.new(tokens.flatten, @robot).run
      end
    end

    class Interpreter
      def initialize(command_tokens, robot)
        @commands = command_tokens
        @robot = robot
      end

      # Logic
      # - Ignore command if Place is not the first command
      # - Ignore command if there is exception
      # - 
      def run
        @commands.each do |c|
          case c.text.downcase
          when "place"
            place(c)
          when "report"
            report
          when "move"
            move
          end
        end
      end

      def move
        @robot.move
      end

      def place(c)
        @robot.place(c.args[0].to_i, c.args[1].to_i, c.args[2].downcase.to_sym)
      end

      def report
        puts @robot.report
      end
    end
  end
end
