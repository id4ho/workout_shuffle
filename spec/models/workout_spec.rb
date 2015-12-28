require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:exercise_assignments).inverse_of(:workout) }
    it { should have_many(:exercises).through(:exercise_assignments) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it do
      create(:workout)
      should validate_uniqueness_of(:name).scoped_to(:user_id)
    end
  end
end
