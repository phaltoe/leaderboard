require 'spec_helper'

RSpec.describe Team do
  describe ".new" do
    team = Team.new("Patriots")
    it 'has a name' do
      expect(team.name).to eq("Patriots")
    end
    it 'has a rank' do
      expect(team.rank).to eq(nil)
    end
    it 'has a wins count' do
      expect(team.wins).to eq(0)
    end
    it 'has a loss count' do
      expect(team.losses).to eq(0)
    end
    it 'can register a win' do
      team.register_win!
      expect(team.wins).to eq(1)
    end
    it 'can register a loss' do
      team.register_loss!
      expect(team.losses).to eq(1)
    end
  end
end
