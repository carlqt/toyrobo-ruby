# frozen_string_literal: true

module Toyrobo
  module Validations
    class TableDimensionsValidation
      def self.valid?(dimensions)
        new(dimensions).valid?
      end

      def initialize(dimensions)
        @dimensions = dimensions
      end

      def valid?
        dimensions = @dimensions.split("x")

        return false if dimensions.one? { |d| Integer(d, exception: false).nil? }

        dimensions.count == 2
      end
    end
  end
end
