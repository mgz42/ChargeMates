class TchatMateChannel < ApplicationCable::Channel
  def subscribed
    tchatmate = TchatMate.find(params[:id])
    stream_from "tchat_mate_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user: current_user

  end

end
