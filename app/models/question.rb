class Question < ActiveRecord::Base
	belongs_to :quiz
	has_many :answers

  accepts_nested_attributes_for :answers

	def correct_answer?(attempt)
		self.truth == attempt
	end
end
