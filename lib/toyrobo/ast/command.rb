# frozen_string_literal: true

module Toyrobo
  module AST
    class Command < Node
      attr_accessor :params

      def initialize(value)
        super(value)
        @params = []
      end
    end
  end
end
