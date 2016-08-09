class Poll < ApplicationRecord
  include AASM

	belongs_to 											:user
	has_many 												:options, dependent: :destroy
  has_many                        :votes
	accepts_nested_attributes_for 	:options, allow_destroy: true, reject_if: :all_blank
	validates_presence_of 					:title, :start, :finish, :poll_type, :user_id

	# Set aasm states for polls
	aasm :column => 'state' do
		state :created, :initial => true
		state :opened
		state :closed
    
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

  # Check can user vote or not?
  def self.voted_by_user(poll, user)
    poll.options.each do |poll_option|
      if poll_option.votes.pluck(:user_id).include? user.id
        false
        return
      else
        true
      end
    end  
  end

end
