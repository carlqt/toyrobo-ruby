# frozen_string_literal: true

require_relative "lexers/no_command_error"
require_relative "lexers/token"

module Toyrobo
  # Transforms the input strings into tokens.
  # The implementation is very simple since, as we only have to deal with a single pattern.
  # The lexer will also identify invalid commands
  # There are 3 types of tokens; COMMAND, NUM and STRING
  # COMMAND - Represents the instrcutions the robot will be following
  # NUM - Represents a number. This is to manage type coercion when calling the robot methods
  # STRING - Represents anything that is not a number. Same use as NUM
  class Lexer
    def initialize(input_string)
      @input = input_string.split("\n")
      @tokens = []
    end

    # The implementation always assumes that there are only 2 section of the input, the command and arguments.
    def tokenize
      @input.each do |text|
        cmd, args = text.split(" ")

        if cmd.nil? || Lexers::Token::COMMANDS[cmd.downcase.to_sym].nil?
          raise Lexers::NoCommandError, cmd
        end

        @tokens << Lexers::Token.new(:command, cmd.downcase)
        @tokens += tokenize_params(args) unless args.nil?
      end

      @tokens.flatten
    end

    def tokenize_params(params_string)
      params_string.split(",").map do |val|
        param_type = number?(val) ? :num : :string
        Lexers::Token.new(param_type, val)
      end
    end

    def number?(input)
      input.to_i.to_s == input
    end

    def string?(input)
      !number?(input)
    end

    def tokens
      return @tokens unless @tokens.empty?

      tokenize
    end
  end
end
