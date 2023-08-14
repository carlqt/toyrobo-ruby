# frozen_string_literal: true

module Toyrobo
  module CommandParsers
    # Exceptions to raise when table receives a negative x,y arguments
    class NoCommandError < StandardError
      def initialize(msg = "Command is invalid")
        super
      end
    end
  end
end
