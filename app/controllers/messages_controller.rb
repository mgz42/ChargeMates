# Contrôleur de messages (MessagesController)
class MessagesController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @message = @booking.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to booking_path(@booking), notice: 'Message sent successfully.'
    else
      flash.now[:alert] = 'Failed to send message.'
      render "bookings/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
