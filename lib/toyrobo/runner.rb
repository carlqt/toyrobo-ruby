# frozen_string_literal: true

require "toyrobo/table"
require "toyrobo/robot"
require "toyrobo/lexer"
require "toyrobo/parser"
require "toyrobo/interpreter"

module Toyrobo
  # Entrypoint to run the application
  class Runner
    # TODO: filename and table dimensions should come from params
    def initialize
      @filename = "input.txt"
      table = Toyrobo::Table.new(5, 5)
      @robot = Toyrobo::Robot.new(table)
      @tokens = []
    end

    def run
      File.foreach(@filename) do |f|
        command_parser = Toyrobo::Lexer.new(f)
        @tokens += command_parser.tokens
      end

      interpreter.run
    end

    private

    def parser
      @parser ||= Toyrobo::Parser.new(@tokens.flatten)
    end

    def interpreter
      @interpreter ||= Toyrobo::Interpreter.new(parser.nodes, @robot)
    end
  end
end
