require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'Validates presence' do
    it { should validate_presence_of(:user_library_id) }
    it { should validate_presence_of(:user_id) }
  end

end
