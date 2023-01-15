require 'rails_helper'

RSpec.describe UserLibrary, type: :model do
  describe 'Validates presence' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:book_id) }
  end
end
