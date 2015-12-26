module Exercises
  class CardioExercise < Exercise
    validates :duration,
              numericality: { greater_than: 29, less_than_or_equal_to: 1.hour }
    before_save :ensure_sets_reps_are_nil

    private

    def ensure_sets_reps_are_nil
      self.sets = nil
      self.reps = nil
    end
  end
end
