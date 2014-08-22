class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :camp_id

      t.timestamps
    end
    add_index :skills, :camp_id
  end
end
