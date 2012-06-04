class MarkovBot < Bot

  def reset
    @rounds = 0
    @wins = 0
    @ngrams = Hash.new(Hash.new(0))
    @choices = ["a","b","c"]
  end
  alias initialize reset

  def random_choice
    CHOICES[rand(CHOICES.length)]
  end

  def learn a, b
    @rounds+=1
    @wins += 1 if judge(a,b) == 1
    
    if @rounds > 3
      @ngrams[@choices][b]+=1
    end
    @choices = @choices[1..-1].push "#{a}:#{b}"
  end
  def total
    tot=0
    @ngrams[@choices].each_pair{|k, v|
      tot+=v
    }
    tot
  end
  def choose
    return  random_choice if @rounds < 10
    num = rand(total)
    tot = 0
    @ngrams[@choices].each_pair{|k, v|
      tot+=v
      return what_beats(k) if tot>num
    }
  end
  def performance
    @wins / @rounds.to_f
  end
end
