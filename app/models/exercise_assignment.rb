class ExerciseAssignment < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  validates_presence_of :exercise
  validates_presence_of :workout
  validates_uniqueness_of :exercise_id, scope: :workout_id
end
