class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :option, 		counter_cache: true
  belongs_to :poll, 		counter_cache: true
  validates_presence_of 	:option_vote, :option_id, :user_id
end
