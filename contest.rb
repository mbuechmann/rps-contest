require 'bundler'
Bundler.require

require './judge.rb'
require './bot.rb'

class Contest

  include Judge

  def initialize
    load_bots
    @results = []
    @win_counts = Hash.new(0)
  end

  def start
    @bots.each_with_index do |bot, index|
      @bots.slice(index..(-1)).each do |opponent|
        fight! bot, opponent
      end
    end
    print_overall_results
  end

  private

  def load_bots
    @bots = Dir['./bots/*.rb'].map do |path|
      require path
      File.basename(path).sub('.rb', '').classify.constantize
    end
  end

  def fight!(botclass1, botclass2)
    bot1 = botclass1.new
    bot2 = botclass2.new
    results = 1000.times.map do
      a, b = bot1.choose, bot2.choose
      result = judge a, b
      bot1.learn(a, b)
      bot2.learn(b, a)
      result
    end

    @results.push(:a => bot1, :b => bot2, :results => results)

    sums = [results.count(1), results.count(2), results.count(0)]
    @win_counts[bot1.name] += 1 if sums[0] > sums[1]
    @win_counts[bot2.name] += 1 if sums[0] < sums[1]

    print_avg_result(bot1, bot2, sums)
  end

  def print_overall_results
    @win_counts.each_pair do |bot, count|
      puts "#{bot} won #{count} time#{count != 1 ? 's' : ''}."
    end
  end

  def print_avg_result(a, b, sums)
    puts "#{a.name} vs. #{b.name}:"
    puts '  ' + sums.join(' : ')
  end

end

contest = Contest.new
contest.start

