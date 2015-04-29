class WelcomeEmailSender
  @queue = :welcome_queue

  def self.perform(user_id)
    user = User.find(user_id)
    user.send_welcome_email
  end
end
