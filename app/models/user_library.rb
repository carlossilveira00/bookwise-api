class UserLibrary < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :notes
  validates :user_id, presence: true
  validates :book_id, presence: true
end
