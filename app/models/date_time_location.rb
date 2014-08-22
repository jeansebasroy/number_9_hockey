class DateTimeLocation < ActiveRecord::Base
	belongs_to :camps
	validates :camp_id, presence: true
end
