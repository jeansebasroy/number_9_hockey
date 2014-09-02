class CreatePlayerCampInvitations < ActiveRecord::Migration
  def change
    create_table :player_camp_invitations do |t|
      t.integer :player_id
      t.integer :camp_id
      t.date :invite_date
      t.date :uninvite_date

      t.timestamps
    end
  end
end
