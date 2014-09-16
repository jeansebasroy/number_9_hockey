class Player < ActiveRecord::Base
	has_many :player_evaluations, dependent: :destroy
	has_many :player_camp_invitations

	validates :last_name, presence: true
	#validates ;date_of_birth, date: true
	validates :shoots, presence: true


#	def self.invited(player_id, camp_id)
		#checks to see if player has already been invited to that camp
#		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id)

#		if invitation.empty?
#			invitation = 'empty'
#		else
			#checks to see if it has an univite_date
#			invitation = invitation.first!

#			if invitation.uninvite_date.blank?
#				invitation = 'invited'
#			else
#				invitation = 'uninvited'
#			end
#		end
#	end

end
