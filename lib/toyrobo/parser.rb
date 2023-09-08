# frozen_string_literal: true

require_relative "ast/node"
require_relative "ast/num"
require_relative "ast/string"
require_relative "ast/command"

# Grammar
# CMD is Terminal
# E -> CMD | CMD {ARGS}*
# ARGS -> NUM | STRING

module Toyrobo
  # The Parser takes a sequence of tokens and produces a data structure that can be understood by the interpreter.
  # The data structure is usually an AST but given that the problem is quite simple, it's a list
  # The main responsibility of the parser is to piece together the tokens and associate the commands to their parameters
  class Parser
    def initialize(tokens)
      @tokens = tokens
      @nodes = []
    end

    # Grammar:
    # E -> CMD | CMD ARGS
    def run
      token = consume
      return [] if token.nil? || token.type != :command

      node = AST::Command.new(token.text, token.type)
      node.params = args

      @nodes << node
    end

    def args
      return [] if @tokens[0].nil?

      @tokens.map do |t|
        t.type == :num ? AST::Num.new(t.text, t.type) : Toyrobo::AST::String.new(t.text, t.type)
      end
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
