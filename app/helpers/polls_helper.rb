module PollsHelper

	def show_poll_type(poll)
	  case poll.poll_type
	    when 'radio'
	      'RadioButtons'.html_safe
	    when 'check_box'
	      'Multiply CheckBoxes'.html_safe
		end
	end

	def show_poll_status(poll)
	  case poll.state
	    when 'created'
	      "<span style='color: orange'>
	      Voting will start at #{poll.start.to_formatted_s(:long_ordinal)}
	      </span>".html_safe
	    when 'opened'
	      "<span style='color: dodgerblue'>
	      Voting is in progress. Open until #{poll.finish.to_formatted_s(:long_ordinal)}
	      </span>".html_safe
	    when 'closed'
	      "<span style='color: red'>
	      Voting was closed at #{poll.finish.to_formatted_s(:long_ordinal)}
	      </span>".html_safe
	  end
	end

	def show_poll_options(poll, option)
		case action_name
		when 'index'
		  	if poll.closed?
		  		"<span class='label label-success'>#{option.votes.size}</span></b></p> ".html_safe
	  		else
	  			"</b></p>".html_safe
	  		end
		when 'show'
		  	if poll.voted_by_user(current_user) or poll.closed?
		    	case @poll.poll_type
        		when 'radio'
          			total_votes = @poll.votes.size
        		when 'check_box'
          			total_votes = @poll.votes.pluck(:user_id).uniq.size
      			end

		    	unless total_votes == 0
		      		bar_size = option.votes.size * 100 / total_votes
		    	else
		      		bar_size = 0
		    	end
				"<span class='label label-success'>#{option.votes.size}</span></b></p>    
		    	<div class='progress'>
		      	<div class='progress-bar' role='progressbar' aria-valuenow='2' aria-valuemin='0' aria-valuemax='100' 
		      	style='min-width: 2em; width: #{bar_size}%;'>#{bar_size}%</div></div>".html_safe
		  	else
		  		"</b></p>".html_safe
		  	end
	  	end
	end
end
