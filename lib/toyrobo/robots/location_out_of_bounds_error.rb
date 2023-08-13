# frozen_string_literal: true

module Toyrobo
  module Robots
    # Exceptions to raise when table receives a negative x,y arguments
    class LocationOutOfBoundsError < StandardError
      def initialize(msg = "Location out of bounds")
        super
      end
    end
  end
end
