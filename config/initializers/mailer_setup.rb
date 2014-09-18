ActionMailer::Base.delivery_method = :smtp # be sure to choose SMTP delivery
ActionMailer::Base.smtp_settings = {
  :address              => "p3plcpnl0595.prod.phx3.secureserver.net",
  :port                 => 587,
  :domain               => "number9hockey.com",
  :user_name            => "support@number9hockey.com",
  :password             => "GordieHowe17",
  :authentication       => :plain,
  :enable_starttls_auto => true
}
