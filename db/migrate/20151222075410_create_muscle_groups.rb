class CreateMuscleGroups < ActiveRecord::Migration
  def change
    create_table :muscle_groups do |t|
      t.string :name, null: false, unique: true

      t.timestamps null: false
    end
  end
end
