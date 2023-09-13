# frozen_string_literal: true

RSpec.describe Toyrobo::Runner do
  let(:runner) { described_class.new(options) }
  let(:options) { { filename: input } }

  describe "#run" do
    subject(:run) { runner.run }

    context "when test file contains the GOAL command and with some obstacles" do
      let(:options) { { filename:, obstacles: "1-1,2-1" } }
      let(:filename) { File.join(File.dirname(__FILE__), "../fixtures/runner/input8.txt") }

      it "returns all the coordinates that was visited by the robot" do
        # expect { run }.to output("OUTPUT: 1,2,NORTH\n").to_stdout

        expect { run }.to output("#<Set: {[1, 2], [1, 3], [2, 2], [0, 2], [1, 4], [2, 3]}>\n").to_stdout
      end
    end

    context "when file is input7.txt && the table have obstacles" do
      let(:options) { { filename:, obstacles: "1-3,4-4" } }
      let(:filename) { File.join(File.dirname(__FILE__), "../fixtures/runner/input7.txt") }

      it "returns OUTPUT: 1,2,north" do
        # expect { run }.to output("OUTPUT: 1,2,NORTH\n").to_stdout
        expect { run }.to raise_error(Toyrobo::Robots::LocationOutOfBoundsError)
      end
    end

    context "when file is input1.txt" do
      let(:input) { File.join(File.dirname(__FILE__), "../fixtures/runner/input1.txt") }

      it "returns OUTPUT: 3,3,north" do
        expect { run }.to output("OUTPUT: 3,3,NORTH\n").to_stdout
      end
    end

    context "when file is input2.txt" do
      let(:input) { File.join(File.dirname(__FILE__), "../fixtures/runner/input2.txt") }

      it "returns OUTPUT: 0,0,WEST" do
        expect { run }.to output("OUTPUT: 0,0,WEST\n").to_stdout
      end
    end

    context "when file is input3.txt" do
      let(:input) { File.join(File.dirname(__FILE__), "../fixtures/runner/input3.txt") }

      it "returns empty string in stdout" do
        expect { run }.to output("").to_stdout
      end

      # it "raises NoCommandError" do
      #   expect { run }.to raise_error(Toyrobo::Lexers::NoCommandError)
      # end
    end

    context "when file is input4.txt" do
      let(:input) { File.join(File.dirname(__FILE__), "../fixtures/runner/input4.txt") }

      it "returns OUTPUT: 0,0,NORTH" do
        expect { run }.to output("OUTPUT: 0,0,NORTH\n").to_stdout
      end
    end

    context "when file is input5.txt" do
      let(:input) { File.join(File.dirname(__FILE__), "../fixtures/runner/input5.txt") }

      it "raises ArgumentError" do
        expect { run }.to raise_error(ArgumentError)
      end
    end

    context "when the PLACE command is in the middle" do
      let(:input) { File.join(File.dirname(__FILE__), "../fixtures/runner/input6.txt") }

      it "discards all other commands until a valid PLACE command is found" do
        expect { run }.to output("OUTPUT: 0,0,NORTH\n").to_stdout
      end
    end

    context "when file does not exist" do
      let(:input) { "unknown.txt" }

      it "raises RuntimeError with message File not found" do
        expect { run }.to raise_error(RuntimeError, "File not found")
      end
    end

    context "when dimension option has invalid format" do
      let(:filename) { File.join(File.dirname(__FILE__), "../fixtures/runner/input5.txt") }
      let(:options) { { filename:, dimensions: "1,1" } }

      it "raises RuntimeError with message 'Invalid table dimension format'" do
        expect { run }.to raise_error(RuntimeError, "Invalid table dimension format")
      end
    end
  end
end
