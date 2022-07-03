class PassedTest < ApplicationRecord
	has_one :users
	has_one :tests
	has_many :answer_users
end
