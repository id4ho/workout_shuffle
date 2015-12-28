require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "associations" do
    it do
      should have_many(:exercise_assignments)
        .inverse_of(:exercise)
        .dependent(:destroy)
    end

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

  describe "#display_name" do
    it "should titleize the name string for display purposes" do
      exercise = create(:exercise, name: "awesome squats")

      expect(exercise.display_name).to eq("Awesome Squats")
    end
  end

  describe ".random_with_distinct_primary" do
    before do
      @exercise1 = create(:exercise)
      @exercise2 = create(:exercise, name: "lunges")
      @exercise3 = create(:exercise, name: "curls")

      muscle_group1 = create(:muscle_group)
      muscle_group2 = create(:muscle_group, name: "glutes")

      @exercise1.muscle_targets.create(muscle_group: muscle_group1)
      @exercise2.muscle_targets.create(muscle_group: muscle_group1)
      @exercise3.muscle_targets.create(muscle_group: muscle_group2)

      expect(described_class).to receive(:includes)
        .with(:primary_muscle_group) {
        double(shuffle: [@exercise1, @exercise2, @exercise3])
      }
    end

    it "returns exercises pointing to different primary muscle groups" do
      expect(described_class.random_with_distinct_primary(2)).to eq(
        [@exercise2, @exercise3]
      )
    end

    it "returns the number of exercises requested" do
      expect(described_class.random_with_distinct_primary(2).length).to eq(2)
    end
  end
end
