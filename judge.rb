module Judge
  
  CHOICES = ['Rock', 'Paper', 'Scissors'].freeze

  CHOICE_MAP = {
    'Rock' => 'Scissors',
    'Paper' => 'Rock',
    'Scissors' => 'Paper'
  }.freeze

  def judge choice1, choice2
    CHOICE_MAP[choice1] == choice2 ? 1 : (choice1 == choice2 ? 0 : 2)
  end

  def what_beats choice
    what_gets_beaten_by(what_gets_beaten_by(choice))
  end

  def what_gets_beaten_by choice
    CHOICE_MAP[choice]
  end

end
