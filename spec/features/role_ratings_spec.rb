require 'spec_helper'

describe "Role Rating" do
  before :each do
    FactoryGirl.create :user, username: "Pena"
    FactoryGirl.create :role
    FactoryGirl.create :game
    FactoryGirl.create :score
    sign_in(username:"Pena", password:"Foobar1")
  end
  describe "creation" do
    before :each do
      visit roles_path
      expect(page).to have_content 'tester'
      click_link('tester')
      select "Good", from: "role_rating[score_id]"
      select "testGame", from: "role_rating[game_id]"
      fill_in('role_rating[comment]', with:'me like')
      expect(page).to have_button 'Give rating'
      expect{
        click_button('Give rating')
      }.to change{RoleRating.count}.by(1)
    end

    it "works" do
      click_button('Give rating')
    end

    it "shows on the user page afterwards" do
      click_link('Pena')
      expect(page).to have_content 'Good'
      expect(page).to have_content 'tester'
    end

    it "can be destroyed" do
      page.driver.submit :delete, "/role_ratings/#{RoleRating.first.id}", {}
      click_link('Pena')
      expect(page).not_to have_content 'Good'
      expect(page).not_to have_content 'tester'
    end

  end
end