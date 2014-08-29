class AddToolTypeToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :tool_tip, :text
    add_column :skills, :skill_type, :string
    add_column :skills, :order, :integer
    add_column :skills, :active, :boolean
  end
end
