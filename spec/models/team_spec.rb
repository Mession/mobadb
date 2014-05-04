require 'spec_helper'


describe Team do

  it "cannot have an empty name" do
    t = FactoryGirl.build(:team, name: "")
    expect(t.save).to be(false)
  end

  it "must have a game" do
    t = FactoryGirl.build(:team, game_id: nil)
    expect(t.save).to be(false)
  end

  it "cannot have a negative year" do
    t = FactoryGirl.build(:team, year: -1)
    expect(t.save).to be(false)
  end

  it "cannot be from the future" do
    t = FactoryGirl.build(:team, year: Time.now.year + 1000)
    expect(t.save).to be(false)
  end

  it "is created when it has proper values" do
    FactoryGirl.create(:team, max_members: 5)
    expect(Team.count).to eq(1)
  end

  it "is created when it has proper values and unlimited members" do
    FactoryGirl.create(:team)
    expect(Team.count).to eq(1)
  end

  it "cannot have negative max members" do
    t = FactoryGirl.build(:team, max_members: -1)
    expect(t.save).to be(false)
  end

  it "cannot have zero max members" do
    t = FactoryGirl.build(:team, max_members: 0)
    expect(t.save).to be(false)
  end

  it "max members must be atleast 3" do
    t = FactoryGirl.build(:team, max_members: 2)
    expect(t.save).to be(false)
  end

  describe "method" do
    let(:game){ FactoryGirl.create(:game) }
    let(:game2){ FactoryGirl.create(:game, name:"testGame2") }

    let(:user){ FactoryGirl.create(:user) }
    let(:user2){ FactoryGirl.create(:user, username: "test2") }

    let(:team){ FactoryGirl.create(:team, game: game) }
    let(:team2){ FactoryGirl.create(:team, name: "testteam2", game: game2) }

    let(:membership){ FactoryGirl.create(:membership, team: team, user: user, invitation_status: 1, team_leader: true) }
    let(:membership_invited){ FactoryGirl.create(:membership, team: team, user: user2, invitation_status: 2, team_leader: false) }
    let(:membership_declined){ FactoryGirl.create(:membership, team: team, user: user2, invitation_status: 0, team_leader: false) }

    let(:role_rating){ FactoryGirl.create(:role_rating, user: user, game: game)}
    let(:role_rating2){ FactoryGirl.create(:role_rating, user: user, game: game2)}

    let(:character_rating){ FactoryGirl.create(:champ_rating, user: user, game: game)}
    let(:character_rating2){ FactoryGirl.create(:champ_rating, user: user, game: game2)}


    describe "get_team_role_ratings" do
      it "return nothing when team members haven't rated anything yet" do
        membership

        expect(team.get_team_role_ratings.count).to eq(0);
      end

      it "returns 1 rating when one member has one rating" do
        membership
        role_rating

        expect(team.get_team_role_ratings.count).to eq(1)
      end

      it "return 0 when member has a rating for a different game" do
        membership
        role_rating2

        expect(team.get_team_role_ratings.count).to eq(0)
      end
    end

    describe "get_team_character_ratings" do
      it "return nothing when team members haven't rated anything yet" do
        membership

        expect(team.get_team_character_ratings.count).to eq(0);
      end

      it "returns 1 rating when one member has one rating" do
        membership
        character_rating

        expect(team.get_team_character_ratings.count).to eq(1)
      end

      it "return 0 when member has a rating for a different game" do
        membership
        character_rating2

        expect(team.get_team_character_ratings.count).to eq(0)
      end
    end

    describe "accepted_members" do
      it "must always return atleast 1 member (because a team must always have a leader)" do
        membership

        expect(team.accepted_members.count).to eq(1)
      end 
    
      it "must return the leader when no other members" do
        membership

        expect(team.accepted_members.include?(user)).to be(true)
      end 
    
      it "does not list invited members" do
        membership
        membership_invited

        expect(team.accepted_members.count).to eq(1)
      end 
    
      it "does not list declined members" do
        membership
        membership_declined

        expect(team.accepted_members.count).to eq(1)
      end 
    end

    describe "invited_members" do
      it "is empty when no users invited (but has a leader)" do
        membership

        expect(team.invited_members.count).to eq(0)
      end

      it "has one user when one user invited" do
        membership
        membership_invited

        expect(team.invited_members.count).to eq(1)
      end

      it "has right user object when one user invited" do
        membership
        membership_invited

        expect(team.invited_members.include?(user2)).to be(true)
      end
    
      it "does not list declined members" do
        membership
        membership_declined

        expect(team.invited_members.count).to eq(0)
      end 
    end

    describe "declined_members" do

      it "is empty when no users declined (but has a leader)" do
        membership

        expect(team.declined_members.count).to eq(0)
      end

      it "has one user when one user declined" do
        membership
        membership_declined

        expect(team.declined_members.count).to eq(1)
      end

      it "has right user object when one user declined" do
        membership
        membership_declined

        expect(team.declined_members.include?(user2)).to be(true)
      end
    
      it "does not list invited members" do
        membership
        membership_invited

        expect(team.declined_members.count).to eq(0)
      end 

    end
  end

end

