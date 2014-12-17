class RegistrationTransaction < ActiveRecord::Base
	belongs_to :player_camp_registration

	validates :player_camp_registration_id, presence: true, numericality: { only_integer: true }
	validates :x_amount, presence: true, numericality: true
	validates :x_first_name, presence: true
	validates :x_last_name, presence: true
	validates :x_trans_id, presence: true
	validates :x_type, presence: true

end
