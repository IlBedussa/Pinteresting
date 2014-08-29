ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => "omr-pinteresting18.herokuapp.com",
  :user_name => "davidbedussa21@gmail.com",
  :password => "11092014",
  :authentication => "plain",
  :enable_starttls_auto => true
}