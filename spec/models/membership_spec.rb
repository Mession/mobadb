require 'spec_helper'

# TESTTAA MEMBERSHIPIN POISTUMISTA KUN USER TAI TEAM POISTETAAN
describe Membership do

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user, username: "test2") }
  let(:user3) { FactoryGirl.create(:user, username: "test3") }
  let(:user4) { FactoryGirl.create(:user, username: "test4") }
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
      mem2 = FactoryGirl.build(:membership, user: user, team: team, team_leader: false)
      expect(mem2.save).to be(false)
    end

    it "wont be created if duplicate (second membership leader)" do
      membership
      mem2 = FactoryGirl.build(:membership, user: user, team: team, team_leader: true)
      expect(mem2.save).to be(false)
    end

    it "can be a second different membership in same team" do
      membership
      FactoryGirl.create(:membership, user: user2, team: team, team_leader: false)
      expect(Membership.count).to eq(2)
    end

  end

  describe "when the user is a leader" do
    let(:membership) { FactoryGirl.create(:membership, user: user, team: team, team_leader: true) }

    it "wont be created if duplicate (second membership non-leader)" do
      membership
      mem2 = FactoryGirl.build(:membership, user: user, team: team, team_leader: false)
      expect(mem2.save).to be(false)
    end

    it "wont be created if duplicate (second membership leader)" do
      membership
      mem2 = FactoryGirl.build(:membership, user: user, team: team, team_leader: true)
      expect(mem2.save).to be(false)
    end

    it "cannot have a second leader" do
      membership
      mem2 = FactoryGirl.build(:membership, user: user2, team: team, team_leader: true)
      expect(mem2.save).to be(false)
    end

  end

  describe "when team has a max of 3 members" do
    let(:membership) { FactoryGirl.create(:membership, team: team, team_leader: true) }
    let(:membership2) { FactoryGirl.create(:membership, user: user2, team: team) }
    let(:membership3) { FactoryGirl.create(:membership, user: user3, team: team) }


    it "4th member cannot join" do
      membership
      membership2
      membership3

      mem4 = FactoryGirl.build(:membership, user: user4, team: team)

      expect(mem4.save).to be(false)
      expect(team.members.count).to eq 3
    end

    it "3rd member can join" do
      membership
      membership2

      mem3 = FactoryGirl.build(:membership, user: user3, team: team)

      expect(mem3.save).to be(true)
      expect(team.members.count).to eq 3
    end

  end

  it "is destroyed when membership user is destroyed" do
    FactoryGirl.create(:membership, team: team, user: user)
    expect(Membership.count).to eq(1)

    user.destroy
    expect(Membership.count).to eq(0)
  end

  it "is destroyed when membership team is destroyed" do
    FactoryGirl.create(:membership, team: team, user: user)
    expect(Membership.count).to eq(1)

    team.destroy
    expect(Membership.count).to eq(0)
  end

end
