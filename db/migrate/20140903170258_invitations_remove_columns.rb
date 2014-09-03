class InvitationsRemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :invitations, :player_id
  	remove_column :invitations, :coach_id
  end
end
