require 'spec_helper'


describe Membership do

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user2) }
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

end
