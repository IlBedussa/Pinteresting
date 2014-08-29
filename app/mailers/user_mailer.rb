class UserMailer < ActionMailer::Base
  default from: "no-reply@pinteresting.com"

  def thanks_email(user)
    @user = user
    @url  = "http://omr-pinteresting18.herokuapp.com/"
    mail(:to => @user.name, :subject => "Thanks for your wishes :)")
  end
end
