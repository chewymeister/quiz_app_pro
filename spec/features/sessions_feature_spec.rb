require 'spec_helper'
require_relative 'helpers/sessions_feature_helper'

include Features::SessionHelpers

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
