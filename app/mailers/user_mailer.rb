class UserMailer < Devise::Mailer
  default from: 'kareem@brandly.com'
  default to: 'example@example.com'
  //

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new(Rails.application.secrets.mandrill_api_key)
  end

  def welcome_email(user)
    template_name = "welcome-email"
    template_content = []
    message = {
      to: [{email: user.email}],
      subject: "Welcome to Brandly!",
      merge_vars: [
        {rcpt: user.email,
        vars: [
          {name: "WELCOME_EMAIL_HEADING", content: "Welcome #{user.email}"}
          ]}
      ]
    }


    mandrill_client.messages.send_template template_name, template_content, message
  end
end
