require 'rails_helper'

RSpec.describe MuscleTarget, type: :model do
  context "validations" do
    it { should validate_presence_of(:muscle_group) }
    it { should validate_presence_of(:exercise) }
  end

  context "associations" do
    it { should belong_to(:muscle_group) }
    it { should belong_to(:exercise) }
  end

  context "when creating a non-primary muscle target" do
    context "and the exercise already has a primary target" do
      it "leaves the existing primary muscle target as primary" do
        primary_target = create(:primary_target)
        non_primary_target = MuscleTarget.create(
          primary: false,
          exercise: primary_target.exercise,
          muscle_group: create(:muscle_group)
        )

        expect(primary_target.primary).to be_truthy
      end
    end

    context "and the exercise has no targets" do
      it "sets the muscle target as primary" do
        exercise = create(:exercise)
        first_target = create(:muscle_target, exercise: exercise)

        expect(first_target.primary).to be_truthy
      end
    end
  end

  context "when creating a primary muscle target" do
    context "and the exercise already has a primary target" do
      it "sets new target to primary and unsets primary on the old target" do
        original_primary_target = create(:primary_target)
        exercise = original_primary_target.exercise
        new_primary_target = exercise.muscle_targets.create(
          muscle_group: create(:muscle_group),
          primary: true
        )

        expect(original_primary_target.primary).to be_falsey
        expect(exercise.reload.primary_target).to eq(new_primary_target)
      end
    end

    context "and the exercise has no targets" do
      it "sets the new target as primary" do
        exercise = create(:exercise)
        primary_target = exercise.muscle_targets.create(
          muscle_group: create(:muscle_group),
          primary: true
        )

        expect(primary_target.primary).to be_truthy
      end
    end
  end

  context "when setting a non-primary muscle target to primary" do
    it "sets the prior primary muscle to non-primary" do
      original_primary_target = create(:primary_target)
      exercise = original_primary_target.exercise
      non_primary_target = exercise.muscle_targets.create(
        muscle_group: create(:muscle_group),
      )
      non_primary_target.update(primary: true)
      expect(non_primary_target.primary).to be_truthy
      expect(original_primary_target.primary).to be_falsey
    end
  end
end
