require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "Validates presence" do
      it { should validate_presence_of(:title) }
  end

end
