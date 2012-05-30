
class PredictionBeaterBot < Bot
  def initialize
    @rounds = 0
  end

  def choose
    if @last
      choose_to_beat(@last)
    else
      random_choice
    end
  end

  def random_choice
    CHOICES[rand(CHOICES.length)]
  end

  def choose_to_beat(choice)
    CHOICE_MAP.each_pair.select { |pair|
      pair[1] == choice
    }.first.first
  end

  def learn(a, b)
    @rounds += 1
    @last = b
  end
end
