class Option < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :votes

  #Helper method for Active Admin
  def display_name
  	self.poll_option.truncate(40, separator: ' ')
  end

end
