class ScoutingRequest < ActiveRecord::Base
  validates :first_name, presence: true, 
				length: { maximum: 50 }
  validates :last_name, presence: true, 
				length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
				format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true

  def send_scouting_request(scouting_request)
  	SupportMailer.scouting_request(scouting_request).deliver
  end

end
