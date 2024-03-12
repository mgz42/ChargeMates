class MessagesController < ApplicationController
  before_action :set_booking

  def create
    @booking = Booking.find(params[:booking_id])
    @message = @booking.messages.new(message_params)
    @message.user = current_user

    if @message.save
      TchatMateChannel.broadcast_to(
        @booking,
        ApplicationController.renderer.render(partial: "messages/message", locals: { message: @message, current_user: current_user }, formats: [:html])
      )
      head :ok
    else
      flash.now[:alert] = 'Failed to send message.'
      render "bookings/show", status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
