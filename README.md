# Performance Optimization
This script was profiled using the `memory_profiler` gem. You can generate the report by running:

```ruby
rake "profile[filename,dimensions]"

# e.g.

rake "profile[input.txt,12x12]
```

The problem with the previous implementation is that it's very space inefficient, specifically, `table.rb` and `runner.rb`.

A major improvement for `table.rb` is to remove instantiating an Array and instead, use a `Range` object for tracking the boundaries of the `x` and `y` axis.

For `runner.rb`, previously, the app builds the whole AST of the file in memory, now we'll start executing/interpreting line by line which helps reduce the consumption of memory and greatly reduces the CPU load

## Comparisons
These metrics comes from running:

`rake "profile[input.txt, 99999999x99999999]"`

## Stats for v0.2.0
```
Total allocated: 11.22 MB (267677 objects)
Total retained:  72.00 B (1 objects)

allocated memory by gem
-----------------------------------
  11.22 MB  toyrobo-ruby/lib
   80.00 B  other

allocated memory by file
-----------------------------------
   5.46 MB  toyrobo-ruby/lib/toyrobo/lexer.rb
   2.53 MB  toyrobo-ruby/lib/toyrobo/runner.rb
   1.57 MB  toyrobo-ruby/lib/toyrobo/parser.rb
 629.76 kB  toyrobo-ruby/lib/toyrobo/ast/command.rb
 419.92 kB  toyrobo-ruby/lib/toyrobo/table.rb
 314.95 kB  toyrobo-ruby/lib/toyrobo/interpreter.rb
 294.62 kB  toyrobo-ruby/lib/toyrobo/robot.rb
  832.00 B  toyrobo-ruby/lib/toyrobo/validations/table_dimensions_validation.rb
   80.00 B  /Users/carlwilliamtablante/Projects/toyrobo-ruby/Rakefile

```

## Stats for v0.1.0

```
Total allocated: 3.10 GB (322784 objects)
Total retained:  72.00 B (1 objects)

allocated memory by gem
-----------------------------------
   3.10 GB  toyrobo-ruby/lib
   88.00 B  other

allocated memory by file
-----------------------------------
   1.60 GB  toyrobo-ruby/lib/toyrobo/table.rb
   1.49 GB  toyrobo-ruby/lib/toyrobo/runner.rb
   7.14 MB  toyrobo-ruby/lib/toyrobo/lexer.rb
   2.50 MB  toyrobo-ruby/lib/toyrobo/robot.rb
   1.08 MB  toyrobo-ruby/lib/toyrobo/parser.rb
 944.64 kB  toyrobo-ruby/lib/toyrobo/ast/node.rb
 629.76 kB  toyrobo-ruby/lib/toyrobo/ast/command.rb
 314.95 kB  toyrobo-ruby/lib/toyrobo/interpreter.rb
  832.00 B  toyrobo-ruby/lib/toyrobo/validations/table_dimensions_validation.rb
   88.00 B  /Users/carlwilliamtablante/Projects/toyrobo-ruby/Rakefile
   80.00 B  toyrobo-ruby/lib/toyrobo/validations/input_file_validation.rb
```


# Toyrobo::Ruby

This is my implementation of the Toyrobot problem. It uses Ruby 3.2.2 and rbs for type annotations

## Design

The design makes use of Ruby's metaprogramming to handle sending the commands to the Robot.

The Robot is injected with the table dependency so that it can roam around it.

Parsing the commands from the file is done by using `lexer.rb` to tokenize the inputs. This would also identify any invalid command inputs.

After tokenizing the inputs, the tokens will then be used in `parser.rb` to analyze and create a structure (Very lightweight AST) that the Interpreter could understand. This includes association any arguments to commands when provided.

Lastly, `interpreter.rb` will read the structure and issue the commands to the robot.

The project uses `Steep` for type checking and `rbs` for type annotations.

## Installation

The requirement is to have Ruby 3.2.2

Clone the repository then run `bundle install` to install the dependencies.

Then run `rake build && rake install` to build and install.

Run `rake spec` to run tests
## Usage

Run `toyrobo-carl` to see the CLI help. To run, provide an input file using the `-f` option. e.g.

`toyrobo-carl -f spec/fixtures/runner/input1.txt`

Example inputs can be found on `spec/fixtures/runner` directory

Another approach, this repository contains an exe file that you can run without installing. Simply run `./bin/toyrobo-carl` for the same effect.

## Improvements
The input right now requires a filename and it's not able to pipe inputs from stdin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
