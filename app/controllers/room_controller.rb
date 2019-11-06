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
      @room = Room.create(name: name, number: 10)
      redirect_to "/room/#{name}"
    end
  end

  # GET /room/join
  def join
    @rooms = Room.all
  end

  def show
    @room = Room.find_by(name: params[:id])
    cookies[:room_name] = @room.name
  end

  # DELETE /room/1
  def destroy
    # puts params
    @room = Room.find_by(name: params[:id])
    if @room.present?
      @room.destroy
    end
    redirect_to '/room/join'
  end

  def increment
    @room = Room.find_by(name: params[:id])
    @room.increment!(:number)
    ActionCable.server.broadcast "room_channel_#{@room.id}", content: @room.number
    redirect_to "/room/#{@room.name}"
  end
end
