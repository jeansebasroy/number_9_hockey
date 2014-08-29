class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :camps, :age_group, :age_group_id
  end
end
