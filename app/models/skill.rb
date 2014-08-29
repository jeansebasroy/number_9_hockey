class Skill < ActiveRecord::Base

	validates :name, presence: true
	validates :tool_tip, presence: true
	validates :skill_type, presence: true
	validates :order, presence: true,
						numericality: { only_integer: true }

end
