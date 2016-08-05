FactoryGirl.define do
  factory :poll do
    title "MyString"
    body "MyText"
    start "2016-12-31 11:20:01"
    finish "2016-12-31 12:20:01"
    state :created
    poll_type 1
    user nil
  end
end
