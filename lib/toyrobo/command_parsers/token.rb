# frozen_string_literal: true

module Toyrobo
  module CommandParsers
    # Representation of instructions to our Toyrobot App
    class Token
      COMMANDS = %w[place move left right report].freeze

      attr_accessor :type, :text, :args

      def initialize(type = nil, text = nil)
        @type = type
        @text = text
      end
    end
  end
end
