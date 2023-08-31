# frozen_string_literal: true

module Toyrobo
  module AST
    # Representation of a single Node in an AST
    class Node
      attr_reader :value, :type

      def initialize(value, type)
        @value = value
        @type = type
      end
    end
  end
end
