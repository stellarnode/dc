class EmailWorker
  include Sidekiq::Worker

  def perform(emails, subject, body)
    MainMailer.news_email(emails, subject, body).deliver_now
  end
end
