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

end
