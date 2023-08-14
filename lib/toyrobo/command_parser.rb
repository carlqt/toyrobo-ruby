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
        command, args = text.split(" ")

        if command.nil? || CommandParsers::Token::COMMANDS.none? { |s| s.casecmp(command)&.zero? }
          raise CommandParsers::NoCommandError
        end

        token = CommandParsers::Token.new(:command, command)
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
