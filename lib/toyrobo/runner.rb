# frozen_string_literal: true

require "toyrobo/table"
require "toyrobo/robot"
require "toyrobo/lexer"
require "toyrobo/parser"
require "toyrobo/interpreter"
require_relative "validations/table_dimensions_validation"
require_relative "validations/input_file_validation"

module Toyrobo
  # Entrypoint to run the application
  class Runner
    # TODO: table dimensions should come from params
    def initialize(options)
      @filename = options[:filename]
      @table_dimensions = options[:dimensions] || "5x5"
      @tokens = []
    end

    def run
      validate!

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
      @interpreter ||= Toyrobo::Interpreter.new(parser.nodes, robot)
    end

    def validate_table_dimensions
      return if Toyrobo::Validations::TableDimensionsValidation.valid?(@table_dimensions)

      raise "Invalid table dimension format"
    end

    def robot
      @robot ||= Toyrobo::Robot.new(table)
    end

    def table
      length, width = @table_dimensions.split("x").map(&:to_i) # : Array[Integer]

      Toyrobo::Table.new(length || 5, width || 5)
    end

    def validate_file
      return if Toyrobo::Validations::InputFileValidation.valid?(@filename)

      raise "File not found"
    end

    def validate!
      validate_table_dimensions
      validate_file
    end
  end
end
