module Features

  module QuizHelpers

    def create_quiz(some_title)
      quiz = Quiz.create({ :title => some_title })
    end

  end
  
end
