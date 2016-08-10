module PostsHelper

	def active_class_post(params_category_name, category_name)
	  if params_category_name == category_name
	    '<li role="presentation" class="active">'.html_safe
	  else
	    '<li role="presentation">'.html_safe
	  end
	end

end
