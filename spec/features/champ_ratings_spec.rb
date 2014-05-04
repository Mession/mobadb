require 'spec_helper'

include OwnTestHelper

describe "Champ Rating" do
  before :each do
    FactoryGirl.create :user, username: "Pena"
    FactoryGirl.create :champion
    FactoryGirl.create :score
    sign_in(username:"Pena", password:"Foobar1")
  end
  describe "creation" do
    before :each do
      visit heroes_path
      expect(page).to have_content 'testChamp'
      click_link('testChamp')
      select "Good", from: "champ_rating[score_id]"
      fill_in('champ_rating[comment]', with:'me like')
      expect(page).to have_button 'Give rating'
      expect{
        click_button('Give rating')
      }.to change{ChampRating.count}.by(1)
    end

    it "works" do
      click_button('Give rating')
    end

    it "shows on the user page afterwards" do
      click_link('Pena')
      expect(page).to have_content 'Good'
      expect(page).to have_content 'testChamp'
    end

    it "can be destroyed" do
      page.driver.submit :delete, "/champ_ratings/#{ChampRating.first.id}", {}
      click_link('My Page')
      expect(page).not_to have_content 'Good'
      expect(page).not_to have_content 'testChamp'
    end

  end
end