class Book < ApplicationRecord
  has_many :users, through: :user_libraries
  validates :tittle, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :category, presence: true
  validates :ISBN, presence: true
  validates :ISBN, uniqueness: true
end
