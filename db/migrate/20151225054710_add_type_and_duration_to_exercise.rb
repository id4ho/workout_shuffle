class AddTypeAndDurationToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :type, :string, default: "Exercises::ResistanceExercise", null: false
    add_column :exercises, :duration, :integer
  end
end
