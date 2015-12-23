class CreateMuscleTargets < ActiveRecord::Migration
  def change
    create_table :muscle_targets do |t|
      t.belongs_to :muscle_group, index: true
      t.belongs_to :exercise, index: true
      t.boolean :primary, null: false, default: false

      t.timestamps null: false
    end
  end
end
