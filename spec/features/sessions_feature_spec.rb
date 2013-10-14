require 'spec_helper'

def create_user(first_name, last_name, email, password)
  user = User.create({ first_name: first_name,
  					           last_name: last_name,
  					           email: email,
          					   password: password,
          					   password_confirmation: password })
end

def sign_in(email,password)  
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end

describe 'user sessions' do

  describe 'sign in page' do

  	before(:all) do
      create_user('Bob', 'Job', 'bob@job.com', 'password')
  	end

    it 'allows user to sign in' do
      visit sign_in_path

      expect(page).to have_content('Sign in')
      sign_in('bob@job.com','password')

      expect(current_url).to eq root_url
      expect(page).to have_content 'Welcome back Bob!'
    end

    it 'allows user to sign out' do
      visit sign_in_path
      sign_in('bob@job.com','password')

      click_link 'Sign out'

      expect(page).to have_content 'Goodbye!'
    end

  end

end
