FactoryGirl.define do
  factory :user do
    email FFaker::Internet.email
    username FFaker::Internet.user_name
    password "12345678"
    password_confirmation "12345678"
  end
end
