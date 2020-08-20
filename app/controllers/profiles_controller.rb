class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      sql_query = " \
        profiles.address @@ :query \
        OR profiles.description @@ :query \
      "
      scope = policy_scope(Profile).order(created_at: :desc)
      @profiles = scope.where(sql_query, query: "%#{params[:query]}%")
    else
      @profiles = policy_scope(Profile).order(created_at: :desc)
    end
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
        redirect_to profile_path(@profile)
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
