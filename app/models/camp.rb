class Camp < ActiveRecord::Base
	has_many :date_time_locations, dependent: :destroy
	has_many :player_camp_invitations
	has_many :players, through: :player_camp_invitations

	validates :name, presence: true
	validates :description, presence: true
	
	#VALID_DATE_REGEX = /\A[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\z/i
	#validates :publish_date, format: { with: VALID_DATE_REGEX }
	validates :age_group, presence:true#, numericality: { only_integer: true }


	def self.camp_has_player_invitations()
		# gets all the camps to which the player has been invited
		#camps = PlayerCampInvitations.where(player_id: player_id)

		#PlayerCampInvitations.includes(:camps).where(player_id: player_id)
  		#Camp.all(:include => :player_camp_invitations, :conditions => { :player_camp_invitations => { :player_id => player_id } } )
  		Camp.all.includes(:player_camp_invitations)
	end

	def self.camp_dates_times_rinks(camp_id)
		# gets all the dates for the camp
		dates = DateTimeLocation.where(camp_id: camp_id)

		# creates an array of hashes containing the details of each Date for the Camp
		@camp_dates_times_rinks_array = Array.new

		# cycle through all the Dates
		dates.each do |date|
			# gets all the dates & times information
			date_hash = Hash.new
			date_hash[:id] = date.id
			date_hash[:date] = date.date
			date_hash[:start_time] = date.start_time.strftime('%r')
			date_hash[:end_time] = date.end_time.strftime('%r')

			# gets details about the Rink
			if date.rink_id.nil?
				date_hash[:rink_name] = 'No Rink'
			else
				rink_details = Rink.find(date.rink_id)
				date_hash[:rink_name] = rink_details.name
			end

			# adds the camp hash to the array of camps
			@camp_dates_times_rinks_array.push(date_hash)

		end
		
		@camp_dates_times_rinks_array

	end

end
