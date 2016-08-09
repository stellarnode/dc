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

end
