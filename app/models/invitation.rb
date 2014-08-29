class Invitation < ActiveRecord::Base

	validates :code, presence: true,
				uniqueness: { case_sensitive: true },
				length: { minimum: 8 }
	validates :player_id, numericality: { only_integer: true }
	validates :coach_id, numericality: { only_integer: true }
	validates :expiration_date, presence: true
	#validates :use_date, date

  	def Invitation.new_invitation_code
    	#get a function that generates a manageable invitation_code
    	SecureRandom.urlsafe_base64
  	end	

end
