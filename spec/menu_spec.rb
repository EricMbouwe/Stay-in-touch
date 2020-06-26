require 'rails_helper'

RSpec.describe 'Main Menu Actions', type: :feature do
  before :each do
    User.create(email: 'john@gmail.com', name: 'John', password: 'john1234', password_confirmation: 'john1234')
  end

  it 'Signs up' do
    visit '/users/sign_up'
    fill_in 'user_name', with: 'Eric'
    fill_in 'user_email', with: 'eric@eric.com'
    fill_in 'user_password', with: 'eric1234'
    fill_in 'user_password_confirmation', with: 'eric1234'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'Finds text content \'Forgot your password?\' in the login page' do
    visit '/users/sign_in'
    expect(page).to have_content('Forgot your password?')
  end

  it 'Finds text content \'Signed in successfully\' after logging in' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'john@gmail.com'
    fill_in 'user_password', with: 'john1234'
    click_button 'Log in'
    sleep(2)
    expect(page).to have_content('Signed in successfully')
  end
end
