require 'spec_helper'

describe "Membership" do
  before :each do
    FactoryGirl.create :user, username: "Pena"
    FactoryGirl.create :user, username: "Seppo"
    FactoryGirl.create :game, name: "Dota 2"
    sign_in(username:"Pena", password:"Foobar1")

    visit teams_path
    click_link 'New Team'
    fill_in('team[name]', with:'Tiimi')
    fill_in('team[year]', with:'2014')
    fill_in('team[location]', with:'Oulu')
    select "Dota 2", from: "team[game_id]"
    click_button('Create Team')
  end
  describe "invitation" do
    before :each do
      visit users_path
      click_link 'Seppo'
      select "Tiimi", from: "membership[team_id]"
      click_link
    end

  end
end