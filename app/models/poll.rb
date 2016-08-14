class Poll < ApplicationRecord
  include AASM

	belongs_to 										:user
	has_many 											:options, -> { order(created_at: :asc) }, dependent: :destroy
  has_many                      :votes
	accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank
	validates_presence_of 				:title, :start, :finish, :poll_type, :user_id
  validates                     :poll_type, inclusion:  { in: ['radio', 'check_box'], 
                                                    message: "%{value} is not a valid type" }
  validates                     :state, inclusion:  { in: ['created', 'opened', 'closed'], 
                                                    message: "%{value} is not a valid state" }
  validate                      :must_start_and_finish_properly

  # Validates start & finish datetimes
  def must_start_and_finish_properly
    errors.add(:start, "Start time can't be in the past.") unless start > DateTime.now
    errors.add(:finish, "Finish time can't be in the past.") unless finish > DateTime.now
    errors.add(:start, "Start time can't be after the finish time.") unless finish > start
    errors.add(:finish, "Finish time can't be before the start time.") unless start < finish
  end

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

    event :close_wo_opening do
      transitions :from => :created, :to => :closed
      end
	end

  # Use roles with this model
  resourcify

  # Set number of posts per page
  paginates_per 2

  # Check can user vote or not?
  def voted_by_user(user)
    if self.votes.pluck(:user_id).include? user.id
      return true 
    else
      return false
    end
  end

end
