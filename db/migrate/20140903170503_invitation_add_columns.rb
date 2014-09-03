class InvitationAddColumns < ActiveRecord::Migration
  def change
  	add_column :invitations, :player_id, :integer
  end
end
