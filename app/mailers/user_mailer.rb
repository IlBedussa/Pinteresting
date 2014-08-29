class UserMailer < ActionMailer::Base
  default from: "'David Bedussa' <davidbedussa@gmail.com>"

  def thanks_email(user)
    @user = user
    @url  = "http://omr-pinteresting18.herokuapp.com/"
    mail(:to => @user.email, :subject => "Thanks for your wishes :)")
  end
end
