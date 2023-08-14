# frozen_string_literal: true

module Toyrobo
  module AST
    class Node
      attr_accessor :value

      def initialize(value)
        @value = value
      end
    end
  end
end
