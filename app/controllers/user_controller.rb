class UserController < ApplicationController
  def index
  end

  def create
    cookies[:username] = params[:username]
    redirect_to '/room'
  end

end
