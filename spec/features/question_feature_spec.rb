require 'spec_helper'
require_relative 'helpers/quiz_features_helper'

include Features::QuizHelpers

describe 'questions' do

	before(:all) do
    @quiz = Quiz.create(title: 'Some quiz')
    question1 = Question.create text: 'Is Shoreditch trendy?', truth: true
    question2 = Question.create text: 'Is Josh a reincarnation of Mr. Blobby?', truth: true
    @quiz.questions += [question1, question2]
	end

	describe "answering a question" do

		it 'should display the questions' do 
      visit quizzes_path
      click_link 'Some quiz'
      expect(page).to have_css 'li', 'Is Shoreditch trendy?'
      expect(page).to have_css 'li', 'Is Josh a reincarnation of Mr. Blobby?'
    end

		it 'should allow a user to answer a question with true/false' do
      visit quizzes_path
      click_link 'Some quiz'
      click_link 'Play quiz'

      expect(page).to have_css 'h1', 'Play: Some Quiz'
      within '.question-1' do
        choose 'true'
      end
      within '.question-2' do
        choose 'true'
      end
      click_button 'Submit answers'
    end
		
		it 'a signed in user can add a question'

		it 'a user who is not signed in cannot add a question'

	end

end
