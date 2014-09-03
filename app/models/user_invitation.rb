class UserInvitation < ActiveRecord::Base
	validates :invitation_code, presence: true,
				uniqueness: { case_sensitive: true },
				length: { minimum: 8 }
	validates :player_id, numericality: { only_integer: true }
	#validates :coach_id, numericality: { only_integer: true }
	validates :expiration_date, presence: true
	#validates :use_date, date

  	def self.invitation_code_for_player(player_id)
		# check to see if invitation_code already exists for this player_id
		#  	and that the code has not expired
		existing_code = UserInvitation.where(player_id: player_id)
					#, expiration_date: Date.today)

		if existing_code.empty?

			#creates new Invitation
	    	invitation_code = UserInvitation.new

	    	# generates new invitation codes until the invitation codes does not exist in the database
	    	begin
		    	generated_invitation_code = SecureRandom.urlsafe_base64(8)
			end until UserInvitation.where(invitation_code: generated_invitation_code).empty?

	    	invitation_code.invitation_code = generated_invitation_code
	    	invitation_code.player_id = player_id
	    	invitation_code.expiration_date = (Date.today + 90.days)

	    	invitation_code.save

	    	invitation_code.invitation_code
		
		else
			#if it does, re-serve invitation code & alert user that player has already been invited
			existing_code = existing_code.first

			invitation_code = existing_code.invitation_code

		end  	

  	end	

end
