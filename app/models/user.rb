class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_create :create_remember_token

  has_many :player_camp_invitations
  has_many :camps, through: :player_camp_invitations
	
	validates :first_name, presence: true, 
				length: { maximum: 50 }
	validates :last_name, presence: true, 
				length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
				format: { with: VALID_EMAIL_REGEX }, 
				uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }, :unless => :resetting_password?

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def send_password_reset
  	self.password_reset_token = User.new_remember_token
  	self.password_reset_sent_at = Time.zone.now
    @password_reset = true
  	self.save!
    @password_reset = false
  	UserMailer.password_reset(self).deliver
  end

  def resetting_password?
    @password_reset
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
    
end
