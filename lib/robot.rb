class Robot

  # The DeadRobotError that raises if you try to heal an already dead Robot.
  class DeadRobotError < StandardError

  end

  class NotARobot < StandardError

  end

  MAX_WEIGHT = 250
  DEFAULT_ATTACK = 5
  MAX_HEALTH = 100

  attr_reader :position, :items, :health

  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = MAX_HEALTH
    @equipped_weapon = nil
  end

  def wound(amount)
    @health -= amount
    @health = 0 if health < 0
  end

  def heal(amount)
    @health += amount
    @health = MAX_HEALTH if health > MAX_HEALTH
  end

  def attack(robot)
    if equipped_weapon
      equipped_weapon.hit(robot)
    else
      robot.wound(DEFAULT_ATTACK)
    end
  end

  def pick_up(item)
    if item.is_a?(Weapon)
      self.equipped_weapon = item
    end
    items << item if items_weight + item.weight <= MAX_WEIGHT
  end

  def items_weight
    items.reduce(0) { |sum, item| sum + item.weight }
  end

  def heal!
    if self.health <= 0
      raise DeadRobotError.new('Robot is dead - Cannot heal.')
    end
  end

  def attack!(enemy)
    unless enemy.is_a? Robot
      raise NotARobot.new('Target is not a Robot - Cannot Attack.')
    end
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

end
