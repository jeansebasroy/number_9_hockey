class Camp < ActiveRecord::Base
	has_many :date_time_locations, dependent: :destroy


	validates :name, presence: true
	validates :description, presence: true

end
