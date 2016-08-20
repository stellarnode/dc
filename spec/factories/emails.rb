FactoryGirl.define do
  factory :email do
    subject "MyString"
    body "MyText"
    to "MyText"
    user nil
  end
end
