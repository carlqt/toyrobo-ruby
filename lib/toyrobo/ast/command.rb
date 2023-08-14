# frozen_string_literal: true

module Toyrobo
  module AST
    class Command < Node
      attr_accessor :params

      def initialize(value, type)
        super(value, type)
        @params = []
      end
    end
  end
end
