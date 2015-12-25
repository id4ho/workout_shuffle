class AddLongNameToMuscleGroup < ActiveRecord::Migration
  def change
    add_column :muscle_groups, :long_name, :string
  end
end
