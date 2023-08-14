# frozen_string_literal: true

require_relative "command_parsers/token"

module Toyrobo
  # Parses input strings
  class CommandParser
    def initialize(input_string)
      @input = input_string.split("\n")
      @tokens = []
    end

    def tokenize
      @input.each do |text|
        token = CommandParsers::Token.new
        command, args = text.split(" ")

        if CommandParsers::Token::COMMANDS.any? { |s| s.casecmp(command)&.zero? }
          token.type = :command
          token.text = command
        end

        token.args = args.split(",") unless args.nil?

        @tokens << token
      end

      @tokens.flatten
    end

    def tokens
      return @tokens unless @tokens.empty?

      @tokens ||= tokenize
    end
  end
end
