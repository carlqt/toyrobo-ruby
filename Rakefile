# frozen_string_literal: true

require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "memory_profiler"
require "toyrobo/runner"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop steep]

desc "Runs Steep for typechecking"
task :steep do
  sh "steep check"
end

desc 'Runs profiler and store in ./tmp/profile.txt e.g rake "profile[input.txt, 12x12]"'
task :profile, [:filename, :dimensions] do |_, args|
  options = {
    filename: args.filename,
    dimensions: args.dimensions
  }

  report = MemoryProfiler.report do
    Toyrobo::Runner.new(options).run
  end

  to_file = "./tmp/profiled.txt"

  report.pretty_print(
    to_file:,
    detailed_report: true,
    normalize_paths: true,
    scale_bytes: true
  )

  puts "#{to_file} created"
end
