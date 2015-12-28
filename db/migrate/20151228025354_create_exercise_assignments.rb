class CreateExerciseAssignments < ActiveRecord::Migration
  def change
    create_table :exercise_assignments do |t|
      t.integer :workout_id, null: false
      t.integer :exercise_id, null: false

      t.timestamps null: false
    end
  end
end
