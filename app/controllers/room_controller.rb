class RoomController < ApplicationController
  def index
    unless cookies[:username]
      redirect_to '/'
    end
  end
end
