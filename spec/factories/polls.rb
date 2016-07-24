FactoryGirl.define do
  factory :poll do
    title "MyString"
    body "MyText"
    start "2016-07-11 11:20:01"
    finish "2016-07-11 11:20:01"
    status 1
    poll_type 1
    user nil
  end
end
