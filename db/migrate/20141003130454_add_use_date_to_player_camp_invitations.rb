class AddUseDateToPlayerCampInvitations < ActiveRecord::Migration
  def change
    add_column :player_camp_invitations, :invite_use_date, :date
  end
end
