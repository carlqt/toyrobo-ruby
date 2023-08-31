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
      @input = input_string.strip.downcase
      @tokens = []
    end

    # The implementation always assumes that there are only 2 section of the input, the command and arguments.
    # Note: This can be optimized by only calling downcase on the cmd var
    def tokenize
      cmd, args = @input.split(" ")

      # raise(Lexers::NoCommandError, cmd) if cmd.nil? || Lexers::Token::COMMANDS[cmd.to_sym].nil?

      @tokens << if cmd.nil? || Lexers::Token::COMMANDS[cmd.to_sym].nil?
                   Lexers::Token.new(:unknown, "")
                 else
                   Lexers::Token.new(:command, cmd)
                 end

      @tokens.push(*tokenize_params(args)) unless args.nil?

      @tokens
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
