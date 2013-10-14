class Question < ActiveRecord::Base
	belongs_to :quiz
	has_many :answers

	def correct_answer?(attempt)
		self.truth == attempt
	end
end
