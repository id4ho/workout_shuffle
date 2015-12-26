class MuscleGroup < ActiveRecord::Base
  has_many :muscle_targets, dependent: :destroy
  has_many :exercises, through: :muscle_targets
end
