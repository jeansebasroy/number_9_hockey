class Player < ActiveRecord::Base
	has_many :player_evaluations, dependent: :destroy

	validates :last_name, presence: true
	validates :shoots, presence: true
end
