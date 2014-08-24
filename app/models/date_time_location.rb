class DateTimeLocation < ActiveRecord::Base
	belongs_to :camp

	validates :camp_id, presence: true
end
