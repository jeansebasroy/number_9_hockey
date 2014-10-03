class CreatePlayerCampRegistrations < ActiveRecord::Migration
  def change
    create_table :player_camp_registrations do |t|
      t.integer :player_id
      t.integer :camp_id
      t.string :jersey_size
      t.date :register_date
      t.date :un_register_date
      t.string :terms_agreement

      t.timestamps
    end
  end
end
