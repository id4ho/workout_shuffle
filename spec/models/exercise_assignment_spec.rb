require 'rails_helper'

RSpec.describe ExerciseAssignment, type: :model do
  describe "associations" do
    it { should belong_to(:exercise) }
    it { should belong_to(:workout) }
  end

  describe "validations" do
    it do
      create(:exercise_assignment)
      should validate_uniqueness_of(:exercise_id).scoped_to(:workout_id)
    end
  end
end
