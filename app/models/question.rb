class Question < ApplicationRecord
	has_one :tests
	has_many :answer_options
end
