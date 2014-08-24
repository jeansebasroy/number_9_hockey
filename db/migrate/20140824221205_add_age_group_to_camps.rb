class AddAgeGroupToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :age_group, :integer
  end
end
