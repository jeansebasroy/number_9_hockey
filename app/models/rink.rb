class Rink < ActiveRecord::Base

	validates :name, presence: true
	validates :address, presence: true
	validates :city, presence: true

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	#validates :email, presence: true, 
	#			format: { with: VALID_EMAIL_REGEX }, 
	#			uniqueness: { case_sensitive: false }
	VALID_STATE_REGEX = /\A^(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$\z/i
	validates :state, presence: true, 
				format: { with: VALID_STATE_REGEX }
	VALID_ZIP_REGEX = /\A^\d{5}(-\d{4})?$\z/i
	validates :zip, presence: true, 
				format: { with: VALID_ZIP_REGEX } 
	
end
