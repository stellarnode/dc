class Vote < ApplicationRecord
  belongs_to :option, counter_cache: true
  belongs_to :user
  validates_presence_of :option_vote, :option_id, :user_id
end
