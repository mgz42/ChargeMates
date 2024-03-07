class ConflictsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:new, :create]


  def new
    @conflict = Conflict.new
  end

  def create
    @conflict = Conflict.new(conflict_params)
    @conflict.user = current_user
    @conflict.booking = @booking

    if @conflict.save
      redirect_to @booking, notice: 'Nous avons bien reçu votre signalement.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def conflict_params
    params.require(:conflict).permit(:title, :content, :photo, :resolution)
  end
end
