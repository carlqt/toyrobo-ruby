# frozen_string_literal: true

module Toyrobo
  module AST
    # Node that handles Commands
    class Command < Node
      attr_accessor :params

      def initialize(value, type)
        super
        @params = []
      end
    end
  end
end
