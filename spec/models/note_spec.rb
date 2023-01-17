require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'Validates presence' do
    it { should validate_presence_of(:user_library_id) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
  end

end
