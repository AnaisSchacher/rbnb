class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    scope = policy_scope(Profile).order(created_at: :desc)
    if params[:query].present?
      sql_query = " \
        profiles.address @@ :query \
        OR profiles.description @@ :query \
      "
      @search = scope.where(sql_query, query: "%#{params[:query]}%")
      @profiles = @search.geocoded
      @markers = @profiles.map do |profile|
        {
        lat: profile.latitude,
        lng: profile.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { profile: profile }),
        image_url: helpers.asset_url('logo_fauteuil.png')
        }
      end
    else
      @profiles = scope.geocoded
      @markers = @profiles.map do |profile|
        {
        lat: profile.latitude,
        lng: profile.longitude
        }
      end
    end
  end


  def show
    @profile = Profile.find(params[:id])
    @booking = Booking.new
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

  def destroy
    @profile = Profile.find(params[:id])
    authorize @profile
    @profile.destroy
    redirect_to profiles_path
  end

  private
  def profile_params
    params.require(:profile).permit(:user_id, :title, :address, :available, :category, :price, :description, :photo)
  end
end
