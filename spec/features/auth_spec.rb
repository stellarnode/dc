require 'rails_helper'

RSpec.describe "Auth", :type => :feature do
describe "Sign Up" do
  it "should create new user account" do
    user_count = User.count
    visit new_user_registration_path
    fill_in "Email", :with => "q@q.ru"
    fill_in "Password", :with => "qwerty"
    fill_in "Password confirmation", :with => "qwerty"
    click_button 'Sign up'
    expect(User.count).to eq(user_count + 1)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end  

describe "Sign in and further:" do
  before do
    @user = FactoryGirl.create(:user, :email => "w@w.ru", :password => "qwerty", 
                              :password_confirmation => "qwerty")
    visit new_user_session_path
    fill_in "Email", :with => "w@w.ru"
    fill_in "Password", :with => "qwerty"
    click_button 'Sign in'
  end
  
  it "should successfully login" do
    user_sign_in_count = @user.sign_in_count
    user = User.find(@user.id)
    expect(user.sign_in_count).to eq(user_sign_in_count + 1)
    expect(page).to have_content('Signed in successfully.')
  end

  it "should successfully change account data" do
    visit edit_user_registration_path
    fill_in "Email", :with => "w2@w2.ru"
    fill_in "Password", :with => "qwerty123"
    fill_in "Password confirmation", :with => "qwerty123"
    fill_in "Current password", :with => "qwerty"
    click_button 'Update'
    user = User.find(@user.id)    
    expect(user.email).to eq('w2@w2.ru')
    expect(page).to have_content('Your account has been updated successfully.')
  end

  it "should successfully delete account" do
    visit edit_user_registration_path
    user_count = User.count
    click_button 'Cancel my account'
    expect(User.count).to eq(user_count - 1)
    expect(page).to have_content('Bye! Your account has been successfully cancelled.')
  end

  # остался без изменений
  it "should not restore password w/a conf email when logged in" do
    visit edit_user_password_path
    expect(page).to have_content('You are already signed in.')
  end

  # остался без изменений
  it "should successfully sign out" do
    click_link "Sign Out"
    expect(page).to have_content('Signed out successfully.')
  end
end

describe "Other" do  
  
  # остался без изменений
  it "should not restore password w/a conf email when not logged in" do
    visit edit_user_password_path
    expect(page).to have_content("You can't access this page without coming from a password reset email.")
  end

  it "should retry to input correct email/password" do
    @user = FactoryGirl.create(:user, :email => "w@w.ru", :password => "qwerty", 
                              :password_confirmation => "qwerty")
    visit new_user_session_path
    fill_in "Email", :with => "q@q.ru"
    fill_in "Password", :with => "qwerty123"
    click_button 'Sign in'
    user_sign_in_count = @user.sign_in_count
    user = User.find(@user.id)
    expect(user.sign_in_count).to eq(user_sign_in_count)
    expect(page).to have_content('Invalid Email or password.')
  end
  
  it "should send email to restore password" do
    @user = FactoryGirl.create(:user, :email => "w@w.ru", :password => "qwerty", 
                              :password_confirmation => "qwerty")
    visit new_user_password_path
    fill_in 'Email', :with => "w@w.ru"
    click_button 'Send me reset password instructions'
    user = User.find(@user.id)
    expect(user.reset_password_token && user.reset_password_sent_at).to_not eq(nil)
    expect(page).to have_content('You will receive an email with instructions')
  end
  
  it "should 'remember me' after login" do
    user = FactoryGirl.create(:user, :email => "w@w.ru", :password => "qwerty", 
                              :password_confirmation => "qwerty")
    visit new_user_session_path
    fill_in "Email", :with => "w@w.ru"
    fill_in "Password", :with => "qwerty"
    page.check('Remember me')
    click_button 'Sign in'
    user = User.find(user.id)
    expect(user.remember_created_at).to_not eq nil
  end
end
end