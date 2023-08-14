# frozen_string_literal: true

require "toyrobo/table"
require "toyrobo/robot"
require "toyrobo/lexer"
require "toyrobo/parser"

module Toyrobo
  # Entrypoint to run the application
  class Runner
    def initialize
      filename = "input.txt"
      table = Toyrobo::Table.new(5, 5)
      @robot = Toyrobo::Robot.new(table)
      @file = File.open(filename)
    end

    def run
      tokens = []
      File.foreach(@file) do |f|
        command_parser = Toyrobo::Lexer.new(f)
        tokens << command_parser.tokens
      end

      parser = Toyrobo::Parser.new(tokens.flatten)
      parser.run
    end
  end
end
