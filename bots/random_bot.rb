class RandomBot < Bot

  def name
    'Totally Unepredictable Bot'
  end

  def choose
    Bot::CHOICES[rand(Bot::CHOICES.length)]
  end

  def learn(choice, opponents_choice)
  end

end
