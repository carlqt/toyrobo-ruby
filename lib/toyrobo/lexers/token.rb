# frozen_string_literal: true

module Toyrobo
  module Lexers
    # Representation of instructions to our Toyrobot App
    class Token
      COMMANDS = {
        place: :place,
        move: :move,
        left: :left,
        right: :right,
        report: :report
      }.freeze

      TYPES = {
        command: :command,
        num: :num,
        string: :string
      }.freeze

      attr_accessor :type, :text, :args

      def initialize(type, text)
        @type = type
        @text = text
      end

      def place?
        @type == :command && @text == "place"
      end
    end
  end
end
