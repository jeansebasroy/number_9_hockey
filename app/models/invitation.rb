class Invitation < ActiveRecord::Base
	validates :code, presence: true,
				uniqueness: { case_sensitive: true },
#				case_sensitive: true,
				length: { minimum: 8 }
	validates :expiration_date, presence: true

  def Invitation.new_invitation_code
    #get a function that generates a manageable invitation_code
    SecureRandom.urlsafe_base64
  end	

end
