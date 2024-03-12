class TchatMateChannel < ApplicationCable::Channel
  def subscribed
    booking = Booking.find(params[:id])
    stream_for booking
  end
end
