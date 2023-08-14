# frozen_string_literal: true

module Toyrobo
  module AST
    class Node
      attr_accessor :value, :type

      def initialize(value, type)
        @value = value
        @type = type.downcase
      end
    end
  end
end
