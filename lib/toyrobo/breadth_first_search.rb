# frozen_string_literal: true

# rubocop:disable Metrics
module Toyrobo
  # Reference -> https://www.johnhawthorn.com/2022/breadth-first-search-in-ruby/
  class BFS
    DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

    def self.start(map, start, target)
      width = map.width.max
      height = map.height.max

      # We use a visited list so that we check each location only once
      # Without this we'd revisit the same locations multiple times and our
      # queue would be very large.
      visited = Set.new

      # The "trick" to my approach that I wanted to share is that my queue is two
      # arrays, "queue" and "next_queue", which allow us to track our steps without
      # extra work.
      # We will be reading each item from "queue" to get our "current" location,
      # and pushing the next steps onto "next_queue".
      # We start with our queue only including the initial position.
      queue = [start]
      next_queue = []

      steps = 0

      until queue.empty?
        # Loop over each item in queue
        queue.each do |pos|
          x, y = pos

          # Have we already visited this position? If so, skip it
          next if visited.include?(pos)

          visited.add(pos)

          # Is this a "wall" in the maze? If so, skip it
          next if map.get(x, y).nil?

          # Have we reached our target? If so, return how many steps we've taken
          return visited if target == pos

          # Try to take another step in each cardinal direction
          DIRS.each do |(dx, dy)|
            nx = x + dx
            ny = y + dy

            # Check that our next step is in bounds
            next if nx.negative? || ny.negative?
            next if nx >= width || ny >= height
            next if map.get(nx, ny).nil?

            # Add our next step to next_queue. There may be duplicates, but we'll
            # sort that out with the visited list when we see it.
            # Keep in mind we'll process everything in "queue" before we start
            # looking at "next_queue".
            next_queue << [nx, ny]
          end
        end

        # Here's where we swap the queues, we start processing what was next_queue,
        # and replace next_queue with a new empty queue.
        queue, next_queue = next_queue, queue.clear

        # Because we process all of queue before next_queue, and this is a BFS, we
        # are looking at our steps in order. As we swap the queues, we increment
        # the steps.
        steps += 1
      end
    end
  end
end
# rubocop:enable Metrics
