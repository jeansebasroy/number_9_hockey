class Camp < ActiveRecord::Base
	has_many :date_time_locations, dependent: :destroy

	validates :name, presence: true
	validates :description, presence: true
	
	#VALID_DATE_REGEX = /\A[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\z/i
	#validates :publish_date, format: { with: VALID_DATE_REGEX }
	validates :age_group, presence:true#, numericality: { only_integer: true }


end
