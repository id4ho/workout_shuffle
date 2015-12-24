class MuscleTarget < ActiveRecord::Base
  belongs_to :muscle_group
  belongs_to :exercise, inverse_of: :primary_target

  before_save :verify_only_one_primary_target
  before_save :set_first_target_to_primary

  private

  def verify_only_one_primary_target
    if primary && exercise.primary_target && exercise.primary_target != self
      exercise.primary_target.update_columns(primary: false)
    end
  end

  def set_first_target_to_primary
    if exercise.muscle_targets.empty?
      self.primary = true
    end
  end
end
