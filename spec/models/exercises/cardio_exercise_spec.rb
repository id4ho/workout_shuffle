require 'rails_helper'

RSpec.describe Exercises::CardioExercise, type: :model do
  it do
    should validate_numericality_of(:duration)
      .is_less_than_or_equal_to(3600)
      .is_greater_than(29)
  end

  describe "#ensure_sets_reps_are_nil" do
    it "removes any values set for sets or reps" do
      exercise = build(:cardio_exercise)
      exercise.sets = 2
      exercise.reps = 10
      exercise.save

      expect(exercise.reps).to be_nil
      expect(exercise.sets).to be_nil
    end
  end
end
