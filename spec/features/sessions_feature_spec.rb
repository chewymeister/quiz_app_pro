require 'spec_helper'
require_relative 'helpers/sessions_feature_helper'

include Features::SessionHelpers

describe 'user sessions' do

  describe 'home page' do

    context 'user links' do

      context 'when signed out' do

        before(:each) do
          visit root_path
        end

        it 'should have a Sign in link' do
          click_link 'Sign in'
          expect(current_url).to eq sign_in_url
        end

        it 'should have a Sign up link' do
          click_link 'Sign up'
          expect(current_url).to eq sign_up_url
        end

        it 'should not have a Sign out link' do
          expect(page).not_to have_link 'Sign out'
        end

      end

      context 'when signed in' do

        before(:each) do
          create_user('Bob', 'Job', 'bob@job.com', 'password')
          visit sign_in_path
          sign_in('bob@job.com','password')
        end

        it 'should not have a Sign in link' do
          expect(page).not_to have_link 'Sign in'
        end

        it 'should not have a Sign up link' do
          expect(page).not_to have_link 'Sign up'
        end

        it 'should have a Sign out link' do
          click_link 'Sign out'
          expect(current_url).to eq root_url
        end

      end

    end

  end

  describe 'sign in page' do

  	before(:all) do
      create_user('Bob', 'Job', 'bob@job.com', 'password')
  	end

    context 'sign in' do
      
      it 'with valid credentials' do
        visit sign_in_path

        expect(page).to have_css('h1', 'Sign in')
        sign_in('bob@job.com','password')

        expect(current_url).to eq root_url
        expect(page).to have_content 'Welcome back Bob!'
      end

      it 'with wrong password' do
        visit sign_in_path

        sign_in('bob@job.com','wrong password')

        expect(current_url).to eq sign_in_url
        expect(page).to have_content(
          'The email or password you typed did not work')
      end

    end

    it 'allows user to sign out' do
      visit sign_in_path
      sign_in('bob@job.com','password')

      click_link 'Sign out'

      expect(page).to have_content 'Goodbye!'
    end

  end

end
