class Player < ActiveRecord::Base
	has_many :player_evaluations, dependent: :destroy

	accepts_nested_attributes_for :player_evaluations

	validates :last_name, presence: true
	validates :shoots, presence: true
end
