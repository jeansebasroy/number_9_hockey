class UserMailer < ActionMailer::Base
  #default from: "support@number9hockey.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Password Reset",
          :from => "support@number9hockey.com")
  end

  def camp_registration_confirmation(user, player, camp)
    @user = user
    @player = player
    @camp = camp
    
    mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Camp Registration Confirmation", 
          :from => "info@number9hockey.com")
  end
end
