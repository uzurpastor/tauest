class AnswerUser < ApplicationRecord
	has_one :answer_options
	has_one :passed_tests
end
