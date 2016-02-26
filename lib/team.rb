class Team
  attr_reader :name, :rank, :wins, :losses
  
  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @rank = 0
  end

  def register_win!
    @wins += 1
  end

  def register_loss!
    @losses += 1
  end

  def win_ratio
    (@wins + 1.0) / (@losses + 1.0)
  end

  def register_rank!(input)
    @rank += input
  end
end
