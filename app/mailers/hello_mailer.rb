class HelloMailer < ApplicationMailer
  default from: "from@example.com"
  def hello_email(user)
    @user = user
    mail(to: @user.email, subject: "Hello")
  end

end
