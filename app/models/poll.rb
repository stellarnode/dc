class Poll < ApplicationRecord
  include AASM

	belongs_to 						:user
	has_many 						:options, -> { includes :votes }, dependent: :destroy
	accepts_nested_attributes_for 	:options
	validates_presence_of 			:title, :start, :finish, :poll_type, :user_id

	# Set aasm states for polls
	aasm :column => 'state' do
		state :created, :initial => true
		state :opened, :closed
    
		event :open do
			transitions :from => :created, :to => :opened
		end
		
		event :close do
			transitions :from => :opened, :to => :closed
    	end
	end

    # Use roles with this model
    resourcify

    # Set number of posts per page
    paginates_per 2

end
