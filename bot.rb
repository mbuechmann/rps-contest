class Bot

  include Judge

  def name
    self.class.name
  end

  def choose
    raise "Implement choose, dude!"
  end

  def learn(choice, opponents_choice)
    raise "Implement learn(choice, opponents_choice), dude!"
  end

end
