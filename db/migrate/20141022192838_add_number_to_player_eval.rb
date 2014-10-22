class AddNumberToPlayerEval < ActiveRecord::Migration
  def change
    add_column :player_evaluations, :jersey_number, :string
	add_column :player_evaluations, :age_group, :string
	add_column :player_evaluations, :level, :string
  end
end
