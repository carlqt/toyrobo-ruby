# frozen_string_literal: true

RSpec.describe Toyrobo::Robot do
  let(:table) { Toyrobo::Table.new(3, 3) }
  let(:robot) { described_class.new(table) }

  describe "#place" do
    context "when arguments are out of bounds" do
      subject(:place) { robot.place(-4, 4, :north) }

      it "raises Robots::LocationOutOfBoundsError error" do
        expect { place }.to raise_error(Toyrobo::Robots::LocationOutOfBoundsError)
      end
    end

    context "when arguments are within expected boundaries" do
      subject(:place) { robot.place(1, 2, :south) }

      it "updates the robot attributes to the given arguments" do
        place

        expect(robot.x_position).to eq 1
        expect(robot.y_position).to eq 2
        expect(robot.orientation).to eq :south
      end
    end
  end

  describe "#left" do
    context "when orientation is 'north' and sequence is left left left" do
      before do
        robot.left
        robot.left
        robot.left
      end

      it "changes orientation to :east" do
        expect(robot.orientation).to eq :east
      end
    end
  end

  describe "#right" do
    context "when orientation is 'north' and sequence is right right" do
      before do
        robot.right
        robot.right
      end

      it "changes orientation to :south" do
        expect(robot.orientation).to eq :south
      end
    end
  end

  describe "#report" do
    subject(:report) { robot.report }

    it { is_expected.to eq "OUTPUT: 0,0,NORTH" }
  end

  describe "#move" do
    subject(:move) { robot.move }

    context "when sequence is move, move" do
      before do
        robot.move
        robot.move
      end

      it "moves the robot to the correct location" do
        expect(robot.x_position).to eq 0
        expect(robot.y_position).to eq 2
      end
    end

    context "when robot will move to an invalid location" do
      before do
        robot.place(0, 0, :south)
      end

      it "raises Robots::LocationOutOfBOundsError error" do
        expect { move }.to raise_error(Toyrobo::Robots::LocationOutOfBoundsError)
      end
    end
  end
end
