
class NilclassBot < Bot
  STRATEGIES = [:random_choice, :most_common, :least_common]

  def reset
    @choice_counts = Hash.new(0)
    @response_counts = Hash.new(0)
    @rounds = 0
    @wins = 0
    @strategy = :least_common
  end

  alias initialize reset

  def choose
    if @rounds == 0
      random_choice
    else
      pick_strategy if performance < 0.5
      send(@strategy)
    end
  end

  def most_common
    most_common_choice = @response_counts.each_pair.sort { |a, b|
      a[1] <=> b[1]
    }.last.first
    choose_to_beat(most_common_choice)
  end

  def least_common
    least_common_choice = @response_counts.each_pair.sort { |a, b|
      a[1] <=> b[1]
    }.first.first
    choose_to_beat(least_common_choice)
  end

  def choose_to_beat(choice)
    CHOICE_MAP.each_pair.select { |pair|
      pair[1] == choice
    }.first.first
  end

  def pick_strategy
    @strategy = STRATEGIES[rand(STRATEGIES.length)]
  end

  def random_choice
    CHOICES[rand(CHOICES.length)]
  end

  def learn(a, b)
    @choice_counts[a] += 1
    @response_counts[b] += 1
    @rounds += 1
    @wins += 1 if judge(a, b) == 1
  end

  def performance
    @wins / @rounds.to_f
  end
end

