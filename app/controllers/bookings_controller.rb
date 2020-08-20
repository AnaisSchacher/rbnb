class BookingsController < ApplicationController
	def index
    @bookings = Booking.where(user: current_user)
  end
	
	def new
		@profile = Profile.find(params[:profile_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.profile = Profile.find(params[:profile_id])
    start_time = booking_params[:start_time]
    end_time = booking_params[:end_time]
    @booking.price = @booking.duration * @booking.profile.price

    authorize @booking
    if @booking.save
      redirect_to dashboard_path(current_user), notice: "Vous avez réservé une nouvelle annonce!"
    else
      render :new
    end
  end

  def show
  	@booking = Booking.find(params[:id])
  	authorize @booking
  end

  def destroy
  	@booking = Booking.find(params[:id])
    @booking.destroy
    authorize @booking
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end  
end
