module Toyrobo
  class Robot
    ORIENTATIONS = {
      north: :north,
      south: :south,
      east: :east,
      west: :west
    }.freeze

    attr_accessor :orientation

    def initialize
      @orientation = :north
    end

    def orientation=(val)
      raise 'Unknown orientation' if ORIENTATIONS[val].nil?

      @orientation = ORIENTATIONS[val]
    end
  end
end
