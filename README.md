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

Another approach is this repository contains the .exe file that you can run without installing. Simply run `./bin/toyrobo-carl` for the same effect.

Run `rake spec` to run tests
## Usage

Run `toyrobo-carl` to see the CLI help and to run, provide a input file using the `-f` option. e.g.

`toyrobo-carl -f spec/fixtures/runner/input1.txt`

Example inputs can be found on `spec/fixtures/runner` directory

## Improvements
The input right now requires a filename and it's not able to pipe inputs from stdin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
