# frozen_string_literal: true

RSpec.describe Toyrobo::Runner do
  let(:runner) { described_class.new(options) }
  let(:options) { { filename: input } }

  describe "#run" do
    subject(:run) { runner.run }

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

      it "raises NoCommandError" do
        expect { run }.to raise_error(Toyrobo::Lexers::NoCommandError)
      end
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

    # Raise Errno::ENOENT
    context "when file does not exist" do
      let(:input) { "unknown.txt" }

      it "returns OUTPUT: 0,0,NORTH" do
        expect { run }.to output("File not found").to_stdout
      end
    end
  end
end
