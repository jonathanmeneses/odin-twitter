class SignupMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email(user)
    @user = user
    @url = new_user_session_url
    mail(to: @user.email, subject: "Welcome to OdinTwitter, #{@user.username}")
  end
end
