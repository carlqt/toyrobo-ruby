# frozen_string_literal: true

require_relative "ast/node"
require_relative "ast/num"
require_relative "ast/string"
require_relative "ast/command"

module Toyrobo
  # Parser tokens and transforms into a small asts
  class Parser
    attr_reader :nodes

    def initialize(tokens)
      @tokens = tokens
      @nodes = []
    end

    # [Token(command), Token(num), Token(num), Token(string)]
    # [Token(command)]
    def run
      while pending_tokens?
        t = @tokens[0]

        if t.type == :command
          if t.text == "place"
            node = Toyrobo::AST::Command.new(t.text)
            consume

            parse_arguments(node)
            next
          end

          # Else raise error
          consume
          @nodes << Toyrobo::AST::Command.new(t.text)
        end
      end
    end

    def pending_tokens?
      !@tokens.empty?
    end

    def parse_arguments(command_node)
      while @tokens[0].type != :command
        t = @tokens[0]

        param_node = t.type == :num ? Toyrobo::AST::Num.new(t.text) : Toyrobo::AST::String.new(t.text)
        command_node.params << param_node
        consume
      end

      @nodes << command_node
    end

    def consume
      @tokens.shift
    end
  end
end

# Parsing
# If token is command
# If token is == 'place' -> We expect parameters
# else
# Node.new(token)
