class Note < ApplicationRecord
  belongs_to :user_library
  validates :title, presence: true
  validates :user_library_id, presence: true
  validates :body, presence: true
end
