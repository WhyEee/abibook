class UserMailer < ActionMailer::Base
  default from: "Abu DhABI - Abizeitung 2012 <mailer@abibook2012.de>"

  def activation_email(user)
    @user = user
    mail to: user.email, subject: '[Abu DhABI] Dein Zugang wurde freigeschaltet!'
  end
end
