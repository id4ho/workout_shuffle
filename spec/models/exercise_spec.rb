require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "associations" do
    it { should have_many(:muscle_targets) }
    it { should have_many(:muscle_groups) }
    it { should have_one(:primary_target).conditions(primary: true) }
    it do
      should have_one(:primary_muscle_group)
        .through(:primary_target)
        .source(:muscle_group)
    end
  end

  describe "validations" do
    it { should validate_length_of(:name).is_at_least(3) }

    it "should enforce case-insensitive uniqueness" do
      exercise = create(:exercise)
      expect(exercise.name).to eq("squats")
      exercise_dup = build(:exercise, name: "SQUATS")

      expect(exercise_dup).to_not be_valid
    end

    it "should enforce uniqueness despite leading/trailing whitespace" do
      exercise = create(:exercise)
      expect(exercise.name).to eq("squats")
      exercise_dup_one = build(:exercise, name: " squats")
      exercise_dup_two = build(:exercise, name: "squats ")

      expect(exercise_dup_one).to_not be_valid
      expect(exercise_dup_two).to_not be_valid
    end
  end

  describe "display_name" do
    it "should titleize the name string for display purposes" do
      exercise = create(:exercise, name: "awesome squats")

      expect(exercise.display_name).to eq("Awesome Squats")
    end
  end
end
