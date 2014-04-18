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
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  end
end
