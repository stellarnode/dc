class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
    unless @profile
      if params[:id] != current_user.id
        redirect_to root_path, alert: 'Profile not found.'
      else
        @profile = Profile.new
        @profile.user = current_user
        if @profile.save
          redirect_to profile_path(current_user)
        else
          redirect_to root_path, alert: 'Sorry, something went wrong.'
        end
      end
    end
  end

  def edit
    unless @profile.user == current_user
      respond_to do |format|
         format.html { redirect_to profile_path(current_user), alert: 'You can edit only your own profile.' }
       end
    end
  end

  def update
    @user = current_user
    @user.profile.update(permit_profile)
    redirect_to profile_path
  end

  private

  def set_profile
    begin
      @profile = Profile.find(params[:id])
    rescue
      @profile = nil
    end
  end

  def permit_profile
    params.require(:profile).permit(:first_name, :last_name, :middle_name, :phone, :avatar)
  end

end
