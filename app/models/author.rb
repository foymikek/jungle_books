class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :age, presence: true
  
  has_many :books
end
