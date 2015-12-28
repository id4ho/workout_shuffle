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

  describe ".generate_workout_for" do
    before do
      @exercise1 = create(:exercise)
      @exercise2 = create(:exercise, name: "lunges")
      @exercise3 = create(:exercise, name: "curls")
      @cardio_exercise = create(:cardio_exercise)

      expect(Exercises::ResistanceExercise).to receive(:random_with_distinct_primary)
        .with(3) { [@exercise1, @exercise2, @exercise3] }
    end

    it "adds only one cardio exercise" do
      new_workout = described_class.generate_workout(3)
      expect(new_workout.exercises).to include(@cardio_exercise)
    end

    it "adds result from random_with_distinct_primary to exercises assoc." do
      new_workout = described_class.generate_workout(3)
      expect(new_workout.exercises).to include(
        @exercise1, @exercise2, @exercise3
      )
    end
  end
end
