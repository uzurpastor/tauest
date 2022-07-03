class Star < ApplicationRecord
	has_one :users
	has_one :tests
end
