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
    def initialize(options)
      @filename = options[:filename]
      @table_dimensions = options[:dimensions] || "5x5"
      @start_command_flag = false
      @tokens = []
    end

    def run
      validate!

      File.foreach(@filename) do |f|
        lexer = Toyrobo::Lexer.new(f)
        tokens = lexer.tokens

        @start_command_flag = true if tokens[0].text == 'place'

        next unless @start_command_flag

        parse_tree = Toyrobo::Parser.new(lexer.tokens)

        # Start interpreting only if PLACE command is executed
        Toyrobo::Interpreter.new(parse_tree.nodes, robot).run
      end
    end

    private

    def validate_table_dimensions
      return if Toyrobo::Validations::TableDimensionsValidation.valid?(@table_dimensions)

      raise "Invalid table dimension format"
    end

    def robot
      @robot ||= Toyrobo::Robot.new(table)
    end

    def table
      length, width = @table_dimensions.split("x").map(&:to_i)

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
