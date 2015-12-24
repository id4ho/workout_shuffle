class MuscleGroup < ActiveRecord::Base
  has_many :muscle_targets
  has_many :exercises, through: :muscle_targets
end
