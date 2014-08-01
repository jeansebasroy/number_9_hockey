class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :code
      t.string :player_id
      t.string :coach_id
      t.date :expiration_date
      t.date :use_date

      t.timestamps
    end
  end
end
