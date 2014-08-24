class RemoveCampIdFromSkills < ActiveRecord::Migration
  def change
    remove_column :skills, :camp_id, :integer
  end
end
