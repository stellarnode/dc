class Post < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :body, :user_id

  acts_as_commontable
end
