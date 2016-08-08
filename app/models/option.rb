class Option < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :votes
end
