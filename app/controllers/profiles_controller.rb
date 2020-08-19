class ProfilesController < ApplicationController
  def index
    @profiles = policy_scope(Profile).order(created_at: :desc)
  end

  def show
    @profile = Profile.find(params[:id])
    authorize @profile

  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    authorize @profile
      if @profile.save
        redirect_to profile_path(@profile.id)
      else
        render :new
      end
  end

  def edit
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
    authorize @profile
    if @profile.update(profile_params)
      redirect_to profile_path(@profile)
    else
      render :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:user_id, :address, :available, :category, :price, :description)
  end
end
