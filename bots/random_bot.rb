class RandomBot < Bot

  def name
    'Totally Unpredictable Bot'
  end

  def choose
    Bot::CHOICES[rand(Bot::CHOICES.length)]
  end

  def learn(choice, opponents_choice)
  end

end
