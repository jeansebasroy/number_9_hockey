class PlayerCampInvitations < ActiveRecord::Base
	belongs_to :camp
	belongs_to :player

	validates :camp_id, presence: true, numericality: { only_integer: true }
	validates :player_id, presence: true, numericality: { only_integer: true }
	validates :invite_date, presence: true


	def self.invited?(player_id, camp_id)
		#checks to see if player has already been invited to that camp
		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id)

		if invitation.empty?
			false
		else
			#checks to see if it has an univite_date
			invitation = invitation.first!

			if invitation.uninvite_date.blank?
				true
			else
				false
			end
		end
	end

	def self.invite(player_id, camp_id)

		#checks to see if player already has an invitation in the system to that camp
		if PlayerCampInvitations.invited?(player_id, camp_id)
			# if invitation found, update it
			invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id).first!
			invitation.update_attributes(invite_date: Date.today, uninvite_date: nil)

		else 
			# if no invitation found, create one
			invitation = PlayerCampInvitations.new
			invitation.player_id = player_id
			invitation.camp_id = camp_id
			invitation.invite_date = Date.today

			invitation.save

		end

	end	
	
	def self.un_invite(player_id, camp_id)
		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id).first!
		invitation.update_attributes(uninvite_date: Date.today)
	end

end
