require 'spec_helper'
# rivit coveragea varten
MembershipsController
ApplicationController
SessionsController
TeamsController
UsersController
Membership
Team
User

describe User do
  let(:user) { FactoryGirl.create(:user) }

  it "has the username set correctly" do
    user = User.new username:"Pekka"
    
    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  end

  describe "method" do
    let(:team){ FactoryGirl.create(:team) }
    let(:membership_leader){ FactoryGirl.create(:membership, user: user, team: team, team_leader: true) }
    let(:membership_normal){ FactoryGirl.create(:membership, user: user, team: team, team_leader: false) }

    describe "is_leader_of_any_team" do

      it "returns true when leader of a team" do
        membership_leader

        expect(user.is_leader_of_any_team).to be(true)
      end
    
      it "returns false when not a leader (but a member) of a team" do
        membership_normal

        expect(user.is_leader_of_any_team).to be(false)
      end
    
      it "returns false when not a leader or member of any team" do
        expect(user.is_leader_of_any_team).to be(false)
      end

    end

    describe "is_leader_of(team)" do

      it "returns true when leader of given team" do
        membership_leader

        expect(user.is_leader_of(team)).to be(true)
      end

      it "returns false when normal member of given team" do
        membership_normal

        expect(user.is_leader_of(team)).to be(false)
      end

      it "returns false when normal member of given team but leader of another" do
        membership_normal
        team2 = FactoryGirl.create(:team, name: "testTeam 2")
        mem2 = FactoryGirl.create(:membership, user: user, team: team2, team_leader: true)

        expect(user.is_leader_of(team)).to be(false)
      end

    end

    describe "owned_teams" do

      it "returns 1 if leader of one team" do
        membership_leader

        expect(user.owned_teams.count).to eq(1)
      end

      it "has the correct team if leader of one team" do
        membership_leader

        expect(user.owned_teams.include?(team)).to be(true)
      end

      it "returns 2 if leader of two teams" do
        membership_leader
        team2 = FactoryGirl.create(:team, name: "testTeam 2")
        mem2 = FactoryGirl.create(:membership, user: user, team: team2, team_leader: true)

        expect(user.owned_teams.count).to eq(2)
      end

      it "returns 0 if not a member of any team" do
        expect(user.owned_teams.count).to eq(0)
      end

      it "returns 0 if not a leader of any team (but is a member)" do
        membership_normal

        expect(user.owned_teams.count).to eq(0)
      end
    end
  end

end
