class VotesController < ApplicationController
	before_action :authenticate_user!
	
	# Create new votes for poll options
	def create
		unless Poll.voted_by_user(Poll.where(id: params[:votes_params].keys[0]).first, current_user)
	    params[:votes_params].each do |key, value|	
				if value.class != String
					value.each do |_key, _value|
		      	if _value != "" && _value != "0"
				      	new_vote = Vote.new(user: current_user, option_vote: 1, option_id: _key.to_i, poll_id: key.to_i)
				      	new_vote.save!
				    end
					end
				else
					new_vote = Vote.new(user: current_user, option_vote: 1, option_id: value.to_i, poll_id: key.to_i)
				  new_vote.save!
		  	end
		  end
	    poll = Poll.where(:id => Vote.last.poll_id).first	    
	    redirect_to poll_path(poll.id), notice: 'Thanks for your voice!'
	  else
			poll = Poll.where(:id => Poll.where(id: params[:votes_params].keys[0]).first).first	    
	    redirect_to poll_path(poll.id), alert: "You've voted for this poll."	  	
		end
	end
	
	private

	def vote_params
	  params.require(:vote).permit(:option_vote, :user_id, :option_id, :poll_option, :votes_params)
	end

end
