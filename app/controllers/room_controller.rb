class RoomController < ApplicationController
  # GET /room
  def index
    unless cookies[:username]
      redirect_to '/'
    end
  end

  def create
  end

  # POST /room/create
  def make
    name = params[:name]
    if Room.find_by(name: name)
      redirect_to '/'
    else
      @room = Room.create(name: name)
      redirect_to "/room/"
    end
  end

  # GET /room/join
  def join
    @rooms = Room.all
  end

  def show
  end

  # DELETE /room/1
  def destroy
    puts params
    @room = Room.find_by(name: params[:id])
    if @room.present?
      @room.destroy
    end
    redirect_to '/room/join'
  end
end
