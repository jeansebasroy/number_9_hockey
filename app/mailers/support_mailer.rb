class SupportMailer < ActionMailer::Base
  #default from: "support@number9hockey.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def info_request(info_request)
    mail(:to => "js@number9hockey.com; phil@number9hockey.com", :subject => "Info Request",
          :from => "support@number9hockey.com")
  end

  def scouting_request(scouting_request)
    mail(:to => "js@number9hockey.com; phil@number9hockey.com", :subject => "Scouting Request",
          :from => "support@number9hockey.com")
  end

  def support_request(support_request)
  	@support_request = support_request

    mail(:to => "js@number9hockey.com; phil@number9hockey.com", :subject => "Support Request",
          :from => "support@number9hockey.com")
  end

#  def camp_registration_confirmation(user, player, camp)
#    @user = user
#    @player = player
#    @camp = camp
    
#    mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Camp Registration Confirmation", 
#          :from => "info@number9hockey.com")
#  end

end
