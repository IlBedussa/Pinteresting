ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => "local.drop.me:300",
  :user_name => "knowledgedropsat@gmail.com",
  :password => "dropsbysahil",
  :authentication => "plain",
  :enable_starttls_auto => true
}