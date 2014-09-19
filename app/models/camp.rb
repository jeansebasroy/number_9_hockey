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

end
