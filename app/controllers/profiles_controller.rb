class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def edit
    unless @profile.user == current_user or current_user.is_admin?
      respond_to do |format|
         format.html { redirect_to profile_path(current_user), alert: 'You can edit only your own profile.' }
       end
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :middle_name, :phone, :avatar, :avatar_cache, :remove_avatar)
  end

end
