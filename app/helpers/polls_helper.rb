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

	def show_poll_results(poll, option, index, votes)
	  if Poll.voted_by_user(poll, current_user) or poll.closed?
	    unless votes.last == 0
	      bar_size = votes[index] * 100 / votes.last
	    else
	      bar_size = 0
	    end
			"<p>Opt. #{index + 1}: <b>#{option.poll_option}</b>
	    <b><span class='label label-success'>#{votes[index]}</span></b></p>    
	    <div class='progress'>
	      <div class='progress-bar' role='progressbar' aria-valuenow='2' aria-valuemin='0' aria-valuemax='100' 
	      			style='min-width: 2em; width: #{bar_size}%;'>#{bar_size}%</div>
	    </div>".html_safe
	  end
	end

end
