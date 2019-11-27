class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def create
    cookies[:username] = params[:username]
    redirect_to '/room'
  end

end
