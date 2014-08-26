class PlayerEvaluation < ActiveRecord::Base
	belongs_to :player

	validates :player_id, presence: true
end
