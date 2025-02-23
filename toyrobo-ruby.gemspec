# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "toyrobo-ruby"
  spec.version = "0.2.0"
  spec.authors = ["Carl Tablante"]
  spec.email = ["carlwilliam.tablante@gmail.com"]

  spec.summary = "Application of the toy robo problem"
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/carlqt"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "bin"
  spec.executables = ["toyrobo-carl"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
