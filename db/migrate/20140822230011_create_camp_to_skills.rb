class CreateCampToSkills < ActiveRecord::Migration
  def change
    create_table :camp_to_skills do |t|
      t.integer :camp_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
