# frozen_string_literal: true

module Toyrobo
  # Responsible for interpreting the command nodes to run the app properly
  class Interpreter
    def initialize(command_nodes, robot)
      @commands = command_nodes
      @robot = robot
    end

    def run
      @commands.each do |c|
        next @robot.send(c.value, *format_params(c.params)) unless c.params.empty?

        if c.value == "report"
          puts @robot.send(c.value)
        else
          @robot.send(c.value)
        end
      end
    end

    def format_params(params)
      params.map do |param|
        next param.value.to_i if param.type == :num

        param.value.downcase.to_sym
      end
    end
  end
end
