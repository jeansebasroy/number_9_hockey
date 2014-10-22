class PlayerEvaluation < ActiveRecord::Base
	belongs_to :player

	validates :player_id, presence: true, numericality: { only_integer: true }
	validates :evaluation_type, presence: true
	validates :league, presence: true
	validates :date, presence: true
	validates :age_group, presence: true
	
end
