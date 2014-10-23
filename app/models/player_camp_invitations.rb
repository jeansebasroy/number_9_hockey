class PlayerCampInvitations < ActiveRecord::Base
	belongs_to :camps
	belongs_to :players

	validates :camp_id, presence: true, numericality: { only_integer: true }
	validates :player_id, presence: true, numericality: { only_integer: true }
	validates :invite_date, presence: true


	def self.invited(player_id, camp_id)
		#checks to see if player has already been invited to that camp
		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id)

		if invitation.empty?
			invitation = 'empty'
		else
			#checks to see if it has an univite_date
			invitation = invitation.first!

			if invitation.uninvite_date.blank?
				invitation = 'invited'
			else
				invitation = 'uninvited'
			end
		end
	end

	def self.invite(player_id, camp_id)

		#checks to see if player already has an invitation in the system to that camp
		if PlayerCampInvitations.invited(player_id, camp_id) == 'empty'
			# if no invitation found, create one
			invitation = PlayerCampInvitations.new
			invitation.player_id = player_id
			invitation.camp_id = camp_id
			invitation.invite_date = Date.today

			invitation.save

		elsif PlayerCampInvitations.invited(player_id, camp_id) == 'uninvited'
			# if invitation found, update it
			invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id).first!
			invitation.update_attributes(invite_date: Date.today, uninvite_date: nil)

		end

	end	
	
	def self.un_invite(player_id, camp_id)
		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id).first!
		invitation.update_attributes(uninvite_date: Date.today)
	end

	def self.players_with_camp_invitations(players)
		# returns an array of hashes containing the details of every Camp to which the array of Players have been Invited
		@invited_camps_array = Array.new

		# cycles through all the players
		players.each do |player| 
			# find all the player_camp_invitations that have that player_id
			# and haven't been used
			player_camp_invitations = PlayerCampInvitations.where(player_id: player.id,
																	uninvite_date: nil, 
																	invite_use_date: nil)
			
			# cycles through all the player_camp_invitations
			player_camp_invitations.each do |invitations|
				# gets the details of the associated camp
				camp_details = Camp.find(invitations.camp_id)

				# creates a hash for the details of each camp
				camp_hash = Hash.new
				camp_hash[:player_id] = player.id

				camp_hash[:camp_id] = camp_details.id
				camp_hash[:name] = camp_details.name
				camp_hash[:description] = camp_details.description
				camp_hash[:highlights] = camp_details.highlights
				
				#finds the name of the age_group
				age_group = AgeGroup.find(camp_details.age_group)
				camp_hash[:age_group] = age_group.name

				# gets all the Dates for the Camp
				date_array = Array.new
				camp_dates = DateTimeLocation.where(camp_id: camp_details.id)

				camp_dates.each do |date|
					date_array.push(date.date.strftime('%v'))
				end

				camp_hash[:dates] = date_array

				# adds the camp hash to the array of camps
				@invited_camps_array.push(camp_hash)

			end
		end

		@invited_camps_array
  
	end
  	
  	def self.all_camp_invitations()
  		PlayerCampInvitations.all.includes(:camps)
  	end

  	def self.invitation_used(player_id, camp_id)
  		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id).first!
		invitation.update_attributes(invite_use_date: Date.today)
  	end

  	 def self.invitation_un_used(player_id, camp_id)
  		invitation = PlayerCampInvitations.where(player_id: player_id, camp_id: camp_id).first!
		invitation.update_attributes(invite_use_date: nil)
  	end
end
