class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :exercise_assignments, dependent: :destroy, inverse_of: :workout
  has_many :exercises, through: :exercise_assignments

  validates_presence_of :user
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:user_id]

  def self.generate_workout(num_resistance_exercises)
    Workout.new.tap do |workout|
      workout.add_random_resistance_exercises(num_resistance_exercises)
      workout.add_random_cardio_exercise
    end
  end

  def add_random_cardio_exercise
    exercises << Exercises::CardioExercise.single_random
  end

  def add_random_resistance_exercises(num)
    exercises << Exercises::ResistanceExercise.random_with_distinct_primary(num)
  end
end
