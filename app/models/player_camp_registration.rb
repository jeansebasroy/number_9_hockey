class PlayerCampRegistration < ActiveRecord::Base
	belongs_to :players
	belongs_to :camps

	validates :player_id, presence: true, numericality: { only_integer: true }
	validates :camp_id, presence: true, numericality: { only_integer: true }
	validates :jersey_size, presence: true
	validates :register_date, presence: true
	validates :terms_agreement, length: { minimum: 2 }

	def self.player_registered?(player_id, camp_id)
		registration = PlayerCampRegistration.where(player_id: player_id, camp_id: camp_id).first
	end

	def self.players_with_camp_registrations(players)
		# returns an array of hashes containing the details of every Camp to which the array of Players have Registered
		@registered_camps_array = Array.new

		# cycles through all the players
		players.each do |player| 
			# find all the player_camp_registrations that have that player_id
			# and haven't been used
			player_camp_registrations = PlayerCampRegistration.where(player_id: player.id,
																	un_register_date: nil)
			
			# cycles through all the player_camp_registrations
			player_camp_registrations.each do |registrations|
				# gets the details of the associated camp
				camp_details = Camp.find(registrations.camp_id)

				# creates a hash for the details of each camp
				camp_hash = Hash.new
				camp_hash[:player_id] = player.id
				camp_hash[:registration_id] = registrations.id

				camp_hash[:camp_id] = camp_details.id
				camp_hash[:name] = camp_details.name
				camp_hash[:description] = camp_details.description

				# adds the camp hash to the array of camps
				@registered_camps_array.push(camp_hash)

			end
		end

		@registered_camps_array
  
	end
end
