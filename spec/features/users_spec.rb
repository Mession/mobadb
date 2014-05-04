require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and password do not match'
    end

    it "can change password with correct attributes" do
      sign_in(username:"Pekka", password:"Foobar1")
      click_on 'Change password'
      fill_in('user[password]', with:'Barfoo2')
      fill_in('user[password_confirmation]', with:'Barfoo2')
      click_on 'Change password'
      expect(page).to have_content 'User was successfully updated.'
    end

    it "cannot change password with wrong attributes" do
      sign_in(username:"Pekka", password:"Foobar1")
      click_on 'Change password'
      fill_in('user[password]', with:'')
      fill_in('user[password_confirmation]', with:'')
      click_on 'Change password'
      expect(page).to have_content "Password can't be blank"
      expect(page).to have_content "Password is too short (minimum is 3 characters)"
    end

    it "can destroy account" do
      sign_in(username:"Pekka", password:"Foobar1")
      click_on 'Delete your account'
      visit users_path
      expect(page).not_to have_content 'Pekka'
    end
  end

  it "when tries to sign up with blank name, is not added to the system" do
    visit signup_path
    fill_in('user_username', with:'')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Sign up')
    }.to change{User.count}.by(0)
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Sign up')
    }.to change{User.count}.by(1)
  end
end