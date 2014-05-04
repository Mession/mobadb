require 'spec_helper'

include OwnTestHelper

describe "Role" do
  describe "when trying to create" do
    before :each do
      FactoryGirl.create :user
      sign_in(username:"Pekka", password:"Foobar1")
      visit roles_path
      expect(page).to have_content 'New Role'
      click_link('New Role')
      expect(page).to have_content 'Name'
      expect(page).to have_content 'Description'
    end

    it "is not created without a name" do
      expect{
        click_button('Create Role')
      }.not_to change{Role.count}.by(1)
    end

    it "is created with a name" do
      fill_in('role[name]', with:'Carry')
      expect{
        click_button('Create Role')
      }.to change{Role.count}.by(1)
    end

    describe "after creation" do
      before :each do
        fill_in('role[name]', with:'Carry')
        click_button('Create Role')
      end

      it "can be edited with correct attributes" do
        click_on 'Edit role'
        fill_in('role[name]', with:'Support')
        click_on 'Update Role'
        expect(page).to have_content 'Role was successfully updated.'
      end

      it "cannot be edited with blank name" do
        click_on 'Edit role'
        fill_in('role[name]', with:'')
        click_on 'Update Role'
        expect(page).to have_content "Name can't be blank"
      end

      it "can be destroyed" do
        click_on 'Destroy role'
        expect(Role.count).to be(0)
      end
    end

  end

  describe "lists them" do
    before :each do
      FactoryGirl.create :role, name: "Support"
      FactoryGirl.create :role, name: "Carry"
      visit roles_path
    end

    it "shows the names of the roles" do
      expect(page).to have_content 'Carry'
      expect(page).to have_content 'Support'
    end

  end
end