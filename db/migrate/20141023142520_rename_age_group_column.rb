class RenameAgeGroupColumn < ActiveRecord::Migration
  def change
  	rename_column :player_evaluations, :age_group, :age_group_id
  end
end
