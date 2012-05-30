module Judge
  
  CHOICES = ['Rock', 'Paper', 'Scissors'].freeze

  CHOICE_MAP = {
    'Rock' => 'Scissors',
    'Paper' => 'Rock',
    'Scissors' => 'Paper'
  }

  def judge choice1, choice2
    CHOICE_MAP[choice1] == choice2 ? 1 : (choice1 == choice2 ? 0 : 2)
  end

end
