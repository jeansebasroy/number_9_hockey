class CreateDateTimeLocations < ActiveRecord::Migration
  def change
    create_table :date_time_locations do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :camp_id
      t.integer :rink_id

      t.timestamps
    end
    add_index :date_time_locations, :camp_id    
  end
end
