# frozen_string_literal: true

require_relative "command_parsers/no_command_error"

module Toyrobo
  # Parses input strings
  class Lexer
    def initialize(input_string)
      @input = input_string.split("\n")
      @tokens = []
    end

    def tokenize
      @input.each do |text|
        cmd, args = text.split(" ")

        if cmd.nil? || CommandParsers::Token::COMMANDS[cmd.downcase.to_sym].nil?
          raise CommandParsers::NoCommandError
        end

        @tokens << CommandParsers::Token.new(:command, cmd.downcase)
        @tokens += tokenize_params(args) unless args.nil?
      end

      @tokens.flatten
    end

    def tokenize_params(params_string)
      params_string.split(",").map do |val|
        param_type = number?(val) ? :num : :string
        CommandParsers::Token.new(param_type, val)
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
