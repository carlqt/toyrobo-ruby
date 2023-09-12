# frozen_string_literal: true

RSpec.describe Toyrobo::Table do
  describe "#get" do
    let(:table) { described_class.new(5, 5) }

    context "when arguments are out of bounds" do
      subject(:get) { table.get(-4, 4) }

      it { is_expected.to eq nil }
    end

    context "when arguments are within bounds" do
      subject(:get) { table.get(4, 4) }

      it { is_expected.to eq 0 }
    end

    context "when an obstacle is hit" do
      subject(:get) { table.get(3, 4) }

      let(:obstacle) { [[1,2], [3,4]]}
      let(:table) { described_class.new(5, 5, obstacle) }

      it { is_expected.to eq nil }
    end
  end
end
