require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "Validates presence" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:author) }
      it { should validate_presence_of(:category) }
      it { should validate_presence_of(:ISBN) }
  end

  describe "Validates Uniqueness" do
    it { should validate_uniqueness_of(:ISBN) }
  end


end
