class Test < ApplicationRecord
	has_one :users
	has_many :questions
	has_many :stars
	has_many :passed_tests

	def author
		User.find(self.user_id)
	end
end
