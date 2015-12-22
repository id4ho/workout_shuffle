class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.text :description
      t.integer :sets
      t.integer :reps

      t.timestamps null: false
    end
  end
end
