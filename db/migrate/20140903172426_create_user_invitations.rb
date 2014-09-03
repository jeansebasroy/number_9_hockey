class CreateUserInvitations < ActiveRecord::Migration
  def change
    create_table :user_invitations do |t|
      t.string :invitation_code
      t.integer :player_id
      t.integer :coach_id
      t.date :expiration_date
      t.date :use_date

      t.timestamps
    end
  end
end
