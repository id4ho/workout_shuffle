class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :exercise_assignments, inverse_of: :workout
  has_many :exercises, through: :exercise_assignments

  validates_presence_of :user
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:user_id]
end
