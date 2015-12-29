class Exercise < ActiveRecord::Base
  validates_length_of :name, minimum: 3
  validates_uniqueness_of :name

  has_many :exercise_assignments, inverse_of: :exercise, dependent: :destroy
  has_many :muscle_targets
  has_many :muscle_groups, through: :muscle_targets
  has_one :primary_target, -> { where(primary: true) },
                           class_name: "MuscleTarget",
                           inverse_of: :exercise
  has_one :primary_muscle_group, through: :primary_target, source: :muscle_group

  scope :single_random, -> { offset(rand(self.count)).first }

  # If the exercises table grows (a LOT) this will be problematic. At that
  # point this should be turned into a query that joins muscle_target where
  # primary = true, orders by RANDOM() and then pages using an offset passed to
  # the scope until you find `number_to_add`. If `order` happened before `group`
  # it would be way easier, but it doesn't.
  def self.random_with_distinct_primary(number)
    selected = {}

    includes(:primary_muscle_group).shuffle.each do |exercise|
      selected[exercise.primary_muscle_group.id] = exercise
      return selected.values if selected.keys.length >= number
    end
  end

  def name=(name)
    formatted_name = name ? name.strip.downcase : name
    super(formatted_name)
  end

  def display_name
    name.titleize
  end

  def display_duration
    if duration
      minutes = duration / 60.0
      minutes = minutes.to_i if duration % 60 == 0
      "#{ minutes } mins"
    end
  end
end
