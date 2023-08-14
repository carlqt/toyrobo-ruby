# frozen_string_literal: true

RSpec.describe Toyrobo::Parser do
  let(:parser) { described_class.new(input) }

  describe "#run" do
    subject(:run) { parser.run }

    context "when the input contains a token" do
      let(:input) do
        [Toyrobo::Lexers::Token.new(:command, "move")]
      end

      it "returns a list of command nodes" do
        nodes = parser.nodes
        node = nodes[0]

        expect(node.value).to eq "move"
        expect(node.type).to eq :command
      end
    end

    context "when the input contains a command and param tokens" do
      let(:input) do
        [
          Toyrobo::Lexers::Token.new(:command, "place"),
          Toyrobo::Lexers::Token.new(:num, "1")
        ]
      end

      it "returns a list of command nodes" do
        nodes = parser.nodes
        node = nodes[0]
        node_param = node.params[0]

        expect(node.value).to eq "place"
        expect(node.type).to eq :command

        expect(node_param.value).to eq "1"
        expect(node_param.type).to eq :num
      end
    end
  end
end
