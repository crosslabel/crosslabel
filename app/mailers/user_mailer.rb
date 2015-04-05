class UserMailer < Devise::Mailer
  default from: 'kareem@brandly.com'
  default to: 'example@example.com'

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Brandly!', content_type: "text/html")
  end
end
