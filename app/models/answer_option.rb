class AnswerOption < ApplicationRecord
	has_one :questions
	has_many :answer_users
end
