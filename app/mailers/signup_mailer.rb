class SignupMailer < ApplicationMailer
  default from: 'menesestest@gmail.com'

  def welcome_email(user)
    @user = user
    @url = new_user_session_url
    mail(to: @user.email, subject: "Welcome to OdinTwitter, #{@user.username}")
  end
end
