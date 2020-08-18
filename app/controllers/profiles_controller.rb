class ProfilesController < ApplicationController

  def new
    @user = User.find(params[current_user.id])
    @profile = Profiles.new
  end

  def create
    @user = User.find(params[current_user.id])
    @profil = Profiles.new(profil_params)
    @profil.user = @user_profil
      if @profil.save
        redirect_to profil_path(@user_profil)
      else
        render :new
      end
  end


  private
  def profil_params
    params.require(:profil).permit(:user_id, :address, :available, :category, :price, :description)
  end
end
