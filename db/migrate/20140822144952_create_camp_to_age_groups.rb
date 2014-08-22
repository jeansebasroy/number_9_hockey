class CreateCampToAgeGroups < ActiveRecord::Migration
  def change
    create_table :camp_to_age_groups do |t|
      t.integer :camp_id
      t.integer :age_group_id

      t.timestamps
    end
    add_index :camp_to_age_groups, :camp_id
  end
end
