require "rails_helper"

RSpec.describe MainMailer, type: :mailer do

  describe 'news_email' do

    let(:user) { FactoryGirl.create(:user, :email => "stellarnode@ya.ru", :password => "qwerty",
                              :password_confirmation => "qwerty") }
    # let(:users) { User.all }
    # let(:emails) { users.map { |user| user.email} }
    let(:subject) { "Testing email" }
    let(:message) { "Something new" }
    let(:mail) { described_class.news_email([user], subject, message).deliver_now }

    # it 'lists email addresses' do
    #   expect(emails).to eq("")
    # end

    it 'renders the subject' do
      expect(mail.subject).to eq(subject)
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(user.email)
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(ENV['YANDEX_USER'])
    end

    it 'assigns message' do
      expect(mail.body.encoded).to match(message)
    end

  end

end
