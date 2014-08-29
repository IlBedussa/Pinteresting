class UserMailer < ActionMailer::Base
  default from: "sahil1345@gmail.com"

  def thanks_email(user)
    @user = user
    @url  = "http://omr-pinteresting18.herokuapp.com/"
    mail(:to => @user.name, :subject => "Thanks for your wishes :)")
  end
end
