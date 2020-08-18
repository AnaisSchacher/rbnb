class ProfilesController < ApplicationController
  def new
    @user = User.find(params[current_user.id])
    @profile = Profile.new
  end

  def create
    @user = User.find(params[current_user.id])
    @profile = Profile.new(profile_params)
    @profile.user = @user_profile
      if @profile.save
        redirect_to profile_path(@user_profile)
      else
        render :new
      end
  end

  private
  def profile_params
    params.require(:profile).permit(:user_id, :address, :available, :category, :price, :description)
  end
end
