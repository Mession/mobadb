require 'spec_helper'
# rivit coveragea varten
MembershipsController
ApplicationController
RoleRatingsController
RolesController
SessionsController
TeamsController
UsersController
ChampRating
Champion
Game
Membership
Role
RoleRating
Score
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
    let(:team2){ FactoryGirl.create(:team, name: "testTeam 2") }
    let(:membership_leader){ FactoryGirl.create(:membership, user: user, team: team, team_leader: true) }
    let(:membership_normal){ FactoryGirl.create(:membership, user: user, team: team, team_leader: false) }
    let(:invitation){ FactoryGirl.create(:membership, user: user, team: team2, team_leader: false, invitation_status: 2)}

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
        mem2 = FactoryGirl.create(:membership, user: user, team: team2, team_leader: true)

        expect(user.is_leader_of(team)).to be(false)
      end

      it "returns false when not a member of any team" do
        expect(user.is_leader_of(team)).to be(false)
      end

    end

    describe "is_member_of(team)" do

      it "returns true when leader of given team" do
        membership_leader

        expect(user.is_member_of(team)).to be(true)
      end

      it "returns true when normal member of given team" do
        membership_normal

        expect(user.is_member_of(team)).to be(true)
      end

      it "returns false when not a member of any team" do
        expect(user.is_member_of(team)).to be(false)
      end

      it "returns false when not a member of given team but is a member of another" do
        membership_normal
        team2

        expect(user.is_member_of(team2)).to be(false)
      end

      it "returns false when invited to team but not yet accepted" do
        invitation

        expect(user.is_member_of(team2)).to be(false)
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

    describe "invitations" do

      it "returns 0 if no invitations and not a member of any team" do
        expect(user.invitations.count).to eq(0)
      end

      it "returns 0 if no invitations and a member of a team" do
        membership_normal

        expect(user.invitations.count).to eq(0)
      end

      it "returns 1 when there is a invitation" do
        invitation

        expect(user.invitations.count).to eq(1)
      end

      it "returns 1 when there is a invitation and user is a member of a team" do
        membership_normal
        invitation

        expect(user.invitations.count).to eq(1)
      end

      it "has correct invitation when there is one" do
        invitation

        expect(user.invitations.include?(invitation)).to be(true)
      end

    end

    describe "teams" do
      let(:invitation){ FactoryGirl.create(:membership, user: user, team: team2, team_leader: false, invitation_status: 2)}

      it "returns 0 if no invitations and not a member of any team" do
        expect(user.teams.count).to eq(0)
      end

      it "returns 1 if no invitations and a member of a team" do
        membership_normal

        expect(user.teams.count).to eq(1)
      end

      it "returns 0 when there is a invitation and no memberships" do
        invitation

        expect(user.teams.count).to eq(0)
      end

      it "returns 1 when there is a invitation and user is a member of a team" do
        membership_normal
        invitation

        expect(user.teams.count).to eq(1)
      end

      it "has correct team when there is one membership" do
        membership_normal

        expect(user.teams.include?(membership_normal.team)).to be(true)
      end

    end

  end

end
