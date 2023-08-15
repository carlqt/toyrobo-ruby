# frozen_string_literal: true

module Toyrobo
  module Validations
    class InputFileValidation
      def self.valid?(input)
        new(input).valid?
      end

      def initialize(input)
        @input = input
      end

      def valid?
        File.exist?(@input)
      end
    end
  end
end
