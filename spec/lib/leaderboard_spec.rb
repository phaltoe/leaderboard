require 'spec_helper'

RSpec.describe Leaderboard do
  describe ".new" do
    let(:game_leaderboard) do
      Leaderboard.new([
        {
        home_team: "Patriots",
        away_team: "Broncos",
        home_score: 17,
        away_score: 13
        },
        {
          home_team: "Patriots",
          away_team: "Colts",
          home_score: 21,
          away_score: 17
        },
        {
          home_team: "Broncos",
          away_team: "Colts",
          home_score: 24,
          away_score: 7
        },
        {
          home_team: "Broncos",
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
      ])
    end

    it "takes in a list of game data " do
      expect(game_leaderboard.game_data.length).to eql(5)
    end

    it "has a list of teams" do
      expect(game_leaderboard.team_map.length).to eql(4)
    end

    it "has a unique list of teams" do
      expect(game_leaderboard.team_map.length).to eq(4)
    end
  end
end
