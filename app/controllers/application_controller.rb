class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception, prepend: true
	
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :ensure_signup_complete, only: [:new, :create, :update, :destroy]

	def after_sign_in_path_for(resource)
    unless current_user.profile.first_name? && current_user.profile.last_name?
      flash[:warning] = 'Please, fill your profile to avoid this message in future.'
      edit_profile_path(current_user.profile.user_id)
    else
    	root_path
    end
	end

	def ensure_signup_complete
	  # Ensure we don't go into an infinite loop
	  return if action_name == 'finish_signup'
	  # Redirect to the 'finish_signup' page if the user
	  # email hasn't been verified yet
	  if current_user && !current_user.email_verified?
	    redirect_to finish_signup_path(current_user)
	  end
	end

	def authenticate_admin_user!
      redirect_to '/' and return if user_signed_in? && !current_user.is_admin?
      authenticate_user! 
    end

    def current_admin_user
      return nil if user_signed_in? && !current_user.is_admin?
      current_user
    end

  protected
  
 	def configure_permitted_parameters
   	added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
   	devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
   	devise_parameter_sanitizer.permit :account_update, keys: added_attrs
 	end

end