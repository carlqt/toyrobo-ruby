# frozen_string_literal: true

RSpec.describe Toyrobo::Lexer do
  let(:lexer) { described_class.new(input) }

  describe "#tokenize" do
    subject(:tokenize) { lexer.tokenize }

    context "when input is MOVE" do
      let(:input) { "MOVE" }

      it "returns a list of tokens" do
        tokens = subject
        token = tokens[0]

        expect(token.type).to eq :command
        expect(token.text).to eq "move"
      end
    end

    context "when input is 'PLACE 1" do
      let(:input) { "PLACE 1" }

      it "returns a list of tokens" do
        tokens = subject
        token = tokens[0]
        token2 = tokens[1]

        expect(token.type).to eq :command
        expect(token.text).to eq "place"

        expect(token2.type).to eq :num
        expect(token2.text).to eq "1"
      end
    end

    context "when input contains unknown command" do
      let(:input) { "FLY" }

      it "raises NoCommandError error" do
        expect { tokenize }.to raise_error(Toyrobo::Lexers::NoCommandError)
      end
    end
  end
end
