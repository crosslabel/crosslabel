class UserMailer < Devise::Mailer
  default from: 'kareem@brandly.com'
  default to: 'example@example.com'
  //

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new(Rails.application.secrets.mandrill_api_key)
  end

  def welcome_email(user)
    template_name = "crosslabel-default"
    template_content = []
    message = {
      to: [{email: user.email}],
      subject: "Thanks for joining CrossLabel!",
      merge_vars: [
        {rcpt: user.email,
        vars: [
          {name: "WELCOME_EMAIL_HEADING", content: "Hi #{user.username}"},
          {name: "LIST:DESCRIPTION", content: "By signing up for CrossLabel, you sign up for updates from our site. We'll be adding an opt-out option shortly."},
          {name: "LIST:COMPANY", content: "CrossLabel"},
          {name: "HTML:LIST_ADDRESS_HTML", content: "Toronto, Ontario, Canada"}

          ]}
      ]
    }


    mandrill_client.messages.send_template template_name, template_content, message
  end
end
