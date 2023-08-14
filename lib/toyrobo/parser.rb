# frozen_string_literal: true

require_relative "ast/node"
require_relative "ast/num"
require_relative "ast/string"
require_relative "ast/command"

module Toyrobo
  # The Parser takes a sequence of tokens and produces a data structure that can be understood by the interpreter.
  # The data structure is usually an AST but given that the problem is quite simple, it's a list
  # The main responsibility of the parser is to piece together the tokens and associate the commands to their parameters
  class Parser
    def initialize(tokens)
      @tokens = tokens
      @nodes = []
    end

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
