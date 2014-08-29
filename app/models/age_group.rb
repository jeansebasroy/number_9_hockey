class AgeGroup < ActiveRecord::Base

	validates :name, presence: true
	validates :age_start, presence: true, numericality: { only_integer: true }
	validates :age_end, presence: true, numericality: { only_integer: true }
end
