class CreateScoutingRequests < ActiveRecord::Migration
  def change
    create_table :scouting_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
