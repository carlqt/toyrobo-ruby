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
        cmd, args = text.split(" ")

        if cmd.nil? || CommandParsers::Token::COMMANDS[cmd.downcase].nil?
          raise CommandParsers::NoCommandError
        end

        @tokens << CommandParsers::Token.new(:command, cmd.downcase)
        @tokens += tokenize_params(args)

        # Parsers::Command.new(command).tokenize
        # Parsers::Arg.new(args).tokenize

        # if command.nil? || CommandParsers::Token::COMMANDS.none? { |s| s.casecmp(command)&.zero? }
        #   raise CommandParsers::NoCommandError
        # end

        # token = CommandParsers::Token.new(:command, command)
        # token.args = args.split(",") unless args.nil?
        # args.split(",").each {}

        # @tokens << token
      end

      @tokens.flatten
    end
    def tokenize_params(params_string)
      params_string.split(",").map do |val|
        if number?(val)
          CommandParsers::Token.new(:params, val.to_i)
        else
          CommandParsers::Token.new(:params, val.to_sym)
        end
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

# command parser and argument parser

# Parser
# - Splits line in 2
# - Send first element to CommandParser
# - Send 2nd element to ArgParser

# CommandParser
# - checks if string is correct
# - returns a Token

# ArgParser
# - Splits arguments into tokens
# - Coerce parameters to correct types int and symbols
