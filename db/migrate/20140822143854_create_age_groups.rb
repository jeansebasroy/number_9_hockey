class CreateAgeGroups < ActiveRecord::Migration
  def change
    create_table :age_groups do |t|
      t.string :name
      t.integer :age_start
      t.integer :age_end

      t.timestamps
    end
  end
end
