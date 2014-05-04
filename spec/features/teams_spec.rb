require 'spec_helper'

include OwnTestHelper

describe "Team" do
  before :each do
    FactoryGirl.create :team
    FactoryGirl.create :game, name: "Dota 2"
    FactoryGirl.create :team, name: "Dotaveikot", location: "Helsinki", year:2013
  end

  it "is listed" do
    visit teams_path
    expect(page).to have_content "Dotaveikot"
    expect(page).to have_content "2013"
    expect(page).to have_content "Helsinki"
    expect(page).to have_content "testTeam"
    expect(page).to have_content "2004"
    expect(page).to have_content "testland"
  end

  it "can be created with correct attributes" do
    FactoryGirl.create :user, username: "Pena"
    sign_in(username:"Pena", password:"Foobar1")

    visit teams_path
    click_link 'New Team'
    fill_in('team[name]', with:'Tiimi')
    fill_in('team[year]', with:'2014')
    fill_in('team[location]', with:'Oulu')
    select "Dota 2", from: "team[game_id]"
    expect{
      click_button('Create Team')
    }.to change{Team.count}.by(1)
  end

  it "can not be created with wrong attributes" do
    FactoryGirl.create :user, username: "Pena"
    sign_in(username:"Pena", password:"Foobar1")

    visit teams_path
    click_link 'New Team'
    fill_in('team[name]', with:'')
    fill_in('team[year]', with:'2016')
    fill_in('team[location]', with:'Oulu')
    select "Dota 2", from: "team[game_id]"
    expect{
      click_button('Create Team')
    }.to change{Team.count}.by(0)
  end

  it "can be updated with correct attributes" do
    FactoryGirl.create :user, username: "Pena"
    sign_in(username:"Pena", password:"Foobar1")

    visit teams_path
    click_link 'New Team'
    fill_in('team[name]', with:'Tiimi')
    fill_in('team[year]', with:'2014')
    fill_in('team[location]', with:'Oulu')
    select "Dota 2", from: "team[game_id]"
    click_button('Create Team')

    visit edit_team_path(Team.first)

    fill_in('team[name]', with:'Teami')
    click_button('Update Team')
    expect(page).to have_content "Team was successfully updated."
    expect(page).to have_content "Teami"
  end

  it "can not be updated with wrong attributes" do
    FactoryGirl.create :user, username: "Pena"
    sign_in(username:"Pena", password:"Foobar1")

    visit teams_path
    click_link 'New Team'
    fill_in('team[name]', with:'Tiimi')
    fill_in('team[year]', with:'2014')
    fill_in('team[location]', with:'Oulu')
    select "Dota 2", from: "team[game_id]"
    click_button('Create Team')

    visit edit_team_path(Team.first)

    fill_in('team[name]', with:'')
    click_button('Update Team')
    expect(page).to have_content "Name can't be blank"
  end

  it "can be destroyed" do
    FactoryGirl.create :user, username: "Pena"
    sign_in(username:"Pena", password:"Foobar1")

    visit teams_path
    click_link 'New Team'
    fill_in('team[name]', with:'Tiimi')
    fill_in('team[year]', with:'2014')
    fill_in('team[location]', with:'Oulu')
    select "Dota 2", from: "team[game_id]"
    click_button('Create Team')

    click_on('Destroy team')
    visit teams_path
    expect(page).not_to have_content 'Tiimi'
  end
end