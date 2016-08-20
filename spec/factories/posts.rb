FactoryGirl.define do
  factory :post do
    title FFaker::Lorem.phrase
    body FFaker::Lorem.paragraphs 3
    user_id nil
    is_pinned false
    is_draft false
    commentable false
  end
end
