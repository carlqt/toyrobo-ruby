# frozen_string_literal: true

module Toyrobo
  # Entrypoint to run the application
  class Runner
    # TODO: table dimensions should come from params
    def initialize(input_file)
      @filename = input_file
      @robot = Toyrobo::Robot.new
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
