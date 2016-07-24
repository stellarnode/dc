class ApplicationMailer < ActionMailer::Base
  default from: ENV["YANDEX_USER"]
  layout 'mailer'
end
