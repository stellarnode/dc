module ApplicationHelper
 
  def active_class(controller, nav_type)
	  if controller_name == controller
	    '<li class="active">'.html_safe
	  else
	    nav_type == 'dropdown' ? '<li class="dropdown">'.html_safe : '<li>'.html_safe
	  end
	end

end
