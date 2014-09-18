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
#  config.action_mailer.delivery_method = :smtp
#  ActionMailer::Base.smtp_settings = {
#    :address => "p3plcpnl0595.prod.phx3.secureserver.net",
#    :port => 587,
#    :domain => "www.number9hockey.com",
#    :user_name => "support@number9hockey.com",
#    :password => "GordieHowe17",
#    :authentication => :plain,
#    enable_starttls_auto: false  
#  }

  #:port 80, 25, 587, 465 (with ssl)

  #config.action_mailer.delivery_method = :smtp
  #config.action_mailer.perform_deliveries = true
  #config.action_mailer.smtp_settings = {
  #  address:              'p3plcpnl0595.prod.phx3.secureserver.net',
  #  port:                 465,
  #  domain:               'www.number9hockey.com',
  #  user_name:            'support@number9hockey.com',
  #  password:             'GordieHowe17',
  #  authentication:       :login,
  #  enable_starttls_auto: true  
  #  }