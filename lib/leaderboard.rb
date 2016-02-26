# require "spec_helper"
require_relative './team'

class Leaderboard
GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos ",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos ",
      away_team: "Colts   ",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts   ",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos ",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
]
  attr_reader :game_data
  attr_reader :teams
  attr_reader :team_map

  def initialize(game_info)
    @game_info = game_info
    @rank_map = {}
    @team_map = {}
    @game_info.each do |game|
      if @team_map[game[:home_team]].nil?
        @team_map[game[:home_team]] = Team.new(game[:home_team])
      end

      if @team_map[game[:away_team]].nil?
        @team_map[game[:away_team]] = Team.new(game[:away_team])
      end

      if game[:home_score] > game[:away_score]
        @team_map[game[:home_team]].register_win!
        @team_map[game[:away_team]].register_loss!
      end

      if game[:home_score] < game[:away_score]
        @team_map[game[:home_team]].register_loss!
        @team_map[game[:away_team]].register_win!
      end
    end

    @team_map.each do |team, data|
      if @rank_map[team].nil?
        @rank_map[team] = data.win_ratio
      end
    end

    team_rank = @rank_map.sort_by {|team, ratio| ratio}.reverse!

    team_rank.each_with_index do |team, index|
      @team_map[team[0]].register_rank!(index + 1)
    end

    sorted_rank = @team_map.sort_by {|team, info| info.rank}
    @team_map = sorted_rank

  end

  def display
    puts "--------------------------------------------------"
    puts "| Name      Rank      Total Wins    Total Losses |"
    @team_map.each do |team, info|
      puts "| #{team}  #{info.rank}         #{info.wins}             #{info.losses}            |"
    end
    puts "--------------------------------------------------"
  end

  def team_game_summary(team)
    team_summary = nil
    @team_map.each do |team_name, data|
      games_played = data.wins + data.losses
      if team_name == team
        team_summary = "#{team} played #{games_played} games.\n"
        @game_info.each do |team_data|
          game_result = nil
          if team_data[:home_team] == team
            if team_data[:home_score] > team_data[:away_score]
            game_result = "won"
            elsif team_data[:home_score] < team_data[:away_score]
            game_result = "lost"
            end
          team_summary += "They played as the home team againt #{team_data[:away_team]} and #{game_result}: #{team_data[:home_score]} to #{team_data[:away_score]}.\n"

          elsif team_data[:away_team] == team
            if team_data[:away_score] > team_data[:home_score]
              game_result = "won"
            elsif team_data[:away_score] < team_data[:home_score]
              game_result = "lost"
            end
          team_summary += "They played as the away team againt #{team_data[:home_team]} and #{game_result}: #{team_data[:away_score]} to #{team_data[:home_score]}.\n"
          end
        end
      end
    end
    team_summary
  end
end

leaderboard = Leaderboard.new(Leaderboard::GAME_INFO)
puts leaderboard.display
puts leaderboard.team_game_summary("Steelers")
