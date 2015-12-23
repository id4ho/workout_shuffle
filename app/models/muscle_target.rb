class MuscleTarget < ActiveRecord::Base
  belongs_to :muscle_group
  belongs_to :exercise
end
