class MainMailer < ApplicationMailer
  default from: ENV["default_from"]

  def news_email(recipients, subject, message)

    @recipients = recipients
    @message = message
    @subject = subject

    # Line for regular email client:

    mail(to: @recipients, subject: @subject)

  end
end
