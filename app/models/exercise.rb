class Exercise < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :muscle_targets
  has_many :muscle_groups, through: :muscle_targets
  has_one :primary_target, -> { where(primary: true) }, class_name: "MuscleTarget", inverse_of: :exercise
  has_one :primary_muscle_group, through: :primary_target, source: :muscle_group
end
