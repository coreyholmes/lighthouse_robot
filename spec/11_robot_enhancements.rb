require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @laser = Laser.new
  end

  describe '#heal!' do
    it 'Raise an exception if the robot is already at 0 health or less.' do
    expect(@robot).to receive(:health).and_return(0)
    expect{ @robot.heal! }.to raise_error(Robot::DeadRobotError)
    end
  end

  describe '#attack!' do
    it 'Raise an exception if the thing being attacked is not a Robot' do
      expect{ @robot.attack!(@laser) }.to raise_error(Robot::NotARobot)
    end
  end
end