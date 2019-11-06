module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :room

    def connect
      self.room = get_room_name
    end

    private

      def get_room_name
        puts cookies[:room_name]
        if room = Room.find_by(name: cookies[:room_name])
          room
        else
          reject_unauthorized_connection
        end
      end
  end
end
