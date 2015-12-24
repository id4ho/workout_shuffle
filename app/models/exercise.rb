class Exercise < ActiveRecord::Base
  validates_length_of :name, minimum: 3
  validates_uniqueness_of :name

  has_many :muscle_targets
  has_many :muscle_groups, through: :muscle_targets
  has_one :primary_target, -> { where(primary: true) },
                           class_name: "MuscleTarget",
                           inverse_of: :exercise
  has_one :primary_muscle_group, through: :primary_target, source: :muscle_group

  def name=(name)
    formatted_name = name ? name.strip.downcase : name
    super(formatted_name)
  end

  def display_name
    name.titleize
  end
end
