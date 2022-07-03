class User < ApplicationRecord
  has_many :tests
  has_many :passed_tests
  has_many :stars
  has_secure_password
  validates :password, length: { minimum: 6 },
                       presence: true

  def become_author 
    self.update_attribute :is_author, true
  end
end
