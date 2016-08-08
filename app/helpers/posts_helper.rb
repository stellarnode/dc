module PostsHelper
	def show_poll_type(poll)
	  case poll.poll_type
	    when 'radio'
	      'RadioButtons'.html_safe
	    when 'check_box'
	      'Multiply CheckBoxes'.html_safe
		end
	end
end
