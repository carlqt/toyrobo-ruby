# frozen_string_literal: true

module Toyrobo
  module Lexers
    # Exceptions to raise when table receives a negative x,y arguments
    class NoCommandError < StandardError
      def initialize(command = nil)
        msg = if command.nil?
                "Command is invalid"
              else
                "#{command} Command is invalid"
              end

        super(msg)
      end
    end
  end
end
