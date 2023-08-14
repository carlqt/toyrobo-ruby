# frozen_string_literal: true

require_relative "ast/node"
require_relative "ast/num"
require_relative "ast/string"
require_relative "ast/command"

module Toyrobo
  # Parser tokens and transforms into a small asts
  class Parser
    def initialize(tokens)
      @tokens = tokens
      @nodes = []
    end

    # [Token(command), Token(num), Token(num), Token(string)]
    # [Token(command)]
    def run
      while pending_tokens?
        t = @tokens[0]

        next if t.type != :command

        node = AST::Command.new(t.text, t.type)
        consume
        parse_arguments(node)
      end

      @nodes
    end

    def pending_tokens?
      !@tokens.empty?
    end

    def parse_arguments(command_node)
      while @tokens[0] && @tokens[0].type != :command
        t = @tokens[0]

        param_node = t.type == :num ? AST::Num.new(t.text, t.type) : Toyrobo::AST::String.new(t.text, t.type)
        command_node.params << param_node
        consume
      end

      @nodes << command_node
    end

    def consume
      @tokens.shift
    end

    def nodes
      return @nodes unless @nodes.empty?

      run
    end
  end
end
