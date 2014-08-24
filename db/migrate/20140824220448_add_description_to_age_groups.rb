class AddDescriptionToAgeGroups < ActiveRecord::Migration
  def change
    add_column :age_groups, :description, :string
  end
end
