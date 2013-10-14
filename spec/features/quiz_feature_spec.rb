require 'spec_helper'

def create_quiz(some_title)
  quiz = Quiz.create({ :title => some_title })
end

describe 'the quizzes section' do
  
  before(:all) do
    create_quiz 'Some quiz'
  end

  describe '/quizzes' do
    it 'should display quizzes' do
      visit quizzes_path

      expect(page).to have_content 'Some quiz'
    end
  end

  describe 'an individual quiz' do
    it 'has its own page' do
      visit quizzes_path
      click_link 'Some quiz'

      expect(page).to have_css 'h1', text: 'Some quiz'
    end

    # it 'has a list of questions' do
    #   visit quizzes_path
    #   click_link 'Some quiz'

    #   expect(page).to have_css 'ul li', text: 'Some question'
    # end
  end

  describe 'new quiz form' do
    it 'creates a new quiz' do
      visit new_quiz_path

      within '.new_quiz' do
        fill_in 'Title', with: 'Brand new quiz'
        click_button "Create Quiz"
      end

      expect(current_url).to eq url_for(Quiz.last)
      expect(page).to have_content 'Brand new quiz'
    end

    it 'can also create a new question' do
      visit new_quiz_path

      fill_in "Title", with: 'Quiz title'
      fill_in "Question 1", with: 'What is your name?'
      select('true', :from => 'Answer 1')
      click_button 'Create Quiz'

      expect(page).to have_css 'li', text: 'What is your name? : true'
      expect(Quiz.last.questions).not_to be_empty
    end

    it 'should not accept a new quiz without a title' do
      visit new_quiz_path
      click_button 'Create Quiz'

      expect(page).to have_content 'error'
    end

    it 'should not accept a new quiz with the same title as another quiz' do
      create_quiz('Some quiz')

      visit new_quiz_path
      fill_in "Title", with: 'Some quiz'
      click_button 'Create Quiz'

      expect(page).to have_content 'error'
    end

  end

end
