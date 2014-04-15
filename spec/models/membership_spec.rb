require 'spec_helper'

# TESTTAA MEMBERSHIPIN POISTUMISTA KUN USER TAI TEAM POISTETAAN
describe Membership do

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user2) }
  let(:user3) { FactoryGirl.create(:user3) }
  let(:team) { FactoryGirl.create(:team) }

  describe "when the user is not yet a member" do

    it "is created (not leader)" do
      FactoryGirl.create(:membership, user: user, team: team, team_leader: false)
      expect(Membership.count).to eq(1)
    end

    it "is created (leader)" do
      FactoryGirl.create(:membership, user: user, team: team, team_leader: true)
      expect(Membership.count).to eq(1)
    end
  end

  describe "when the user is a normal member" do
    let(:membership) { FactoryGirl.create(:membership, user: user, team: team, team_leader: false) }

    it "wont be created if duplicate (second membership non-leader)" do
      membership # jotta let() lataisi membershipin
      mem2 = FactoryGirl.build(:membership2, user: user, team: team, team_leader: false)
      expect(mem2.save).to be(false)
    end

    it "wont be created if duplicate (second membership leader)" do
      membership
      mem2 = FactoryGirl.build(:membership2, user: user, team: team, team_leader: true)
      expect(mem2.save).to be(false)
    end

    it "can be a second different membership in same team" do
      membership
      FactoryGirl.create(:membership2, user: user2, team: team, team_leader: false)
      expect(Membership.count).to eq(2)
    end

  end

  describe "when the user is a leader" do
    let(:membership) { FactoryGirl.create(:membership, user: user, team: team, team_leader: true) }

    it "wont be created if duplicate (second membership non-leader)" do
      membership
      mem2 = FactoryGirl.build(:membership2, user: user, team: team, team_leader: false)
      expect(mem2.save).to be(false)
    end

    it "wont be created if duplicate (second membership leader)" do
      membership
      mem2 = FactoryGirl.build(:membership2, user: user, team: team, team_leader: true)
      expect(mem2.save).to be(false)
    end

    it "cannot have a second leader" do
      membership
      mem2 = FactoryGirl.build(:membership2, user: user2, team: team, team_leader: true)
      expect(mem2.save).to be(false)
    end

  end

  describe "when team has a max of 3 members" do
    let(:membership) { FactoryGirl.create(:membership) }
    let(:membership2) { FactoryGirl.create(:membership2) }


    it "4th member cannot join" do
      membership
      membership2
      FactoryGirl.create(:membership3)

      u = FactoryGirl.create(:user, username: "neljas")
      mem4 = FactoryGirl.build(:membership, user: u)

      expect(mem4.save).to be_false
      expect(Membership.count).to eq 3
    end

    it "3rd member can join" do
      membership
      membership2

      mem3 = FactoryGirl.build(:membership3)

      expect(mem3.save).to be_valid
      expect(Membership.count).to eq 3
    end

  end

end
