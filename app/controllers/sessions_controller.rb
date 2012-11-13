class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      flash[:success] = "Signed in!"
      redirect_back_or_to root_url
    else
      flash[:alert] = "Username or password was invalid."
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "Signed out!"
    redirect_to root_url
  end
end
