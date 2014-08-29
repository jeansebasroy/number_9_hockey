class RenameColumn2 < ActiveRecord::Migration
  def change
  	rename_column :camps, :age_group_id, :age_group
  	change_column :camps, :age_group, :string
  end
end
