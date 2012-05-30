class ConstantBot < Bot

  def name
    "Rocky's Rocker Bot"
  end

  def choose
    Bot::CHOICES.first
  end

  def learn(choice, opponents_choice)
  end

end
