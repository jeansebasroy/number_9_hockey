class DateTimeLocation < ActiveRecord::Base
	belongs_to :camp

	validates :date, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validates :camp_id, presence: true, numericality: { only_integer: true }
	validates :rink_id, presence: true, numericality: { only_integer: true }

end
