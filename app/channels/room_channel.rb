class RoomChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber to this channel.
  def subscribed
    puts "THIS IS WHAT IT'S STREAMED FROM"
    puts "#{room.id}"

    stream_from "room_channel_#{room.id}"
    # stream_from "room_#{params[:room]}"
  end
end
