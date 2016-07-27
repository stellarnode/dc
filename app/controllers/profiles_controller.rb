class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def edit
    unless belongs_to_user?(@profile)
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
    #@profile = current_user.profile
    @profile = Profile.find(params[:id])
  end

  def permit_profile
    params.require(:profile).permit(:first_name, :last_name, :middle_name, :phone, :avatar)
  end

end
