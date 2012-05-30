# encoding: utf-8

class PredictionBot < Bot

  def initialize
    @turns = 0
    @stats = Hash.new {|hash, key| 
      hash[key] = {:tries => 0, :successes => 0}
    }
  end

  def name
    "Büchi's Prediction Bot"
  end

  def choose
    @turns += 1
    return random_choice if @turns <= 12
    return Bot::CHOICES[@turns - 12] if @turns < 15
    best_prediction
  end

  def learn choice, opponents_choice
    @stats[choice][:tries] += 1
    if judge(choice, opponents_choice) == 1
      @stats[choice][:successes] += 1
    end
  end

  private

  def random_choice
    Bot::CHOICES[rand(Bot::CHOICES.length)]
  end

  def best_prediction
    quotient = 0.0
    best = Bot::CHOICES.first

    Bot::CHOICES.each do |choice|
      new_quotient = @stats[choice][:successes].to_f / @stats[choice][:tries].to_f
      if new_quotient >= quotient
        best = choice
        quotient = new_quotient
      end
    end

    best
  end

end
