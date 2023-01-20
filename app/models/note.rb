class Note < ApplicationRecord
  belongs_to :user_library
  validates :user_library_id, presence: true
  validates :user_id, presence: true
end
