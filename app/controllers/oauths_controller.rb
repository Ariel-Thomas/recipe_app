class OauthsController < ApplicationController
  skip_before_filter :require_login
      
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end
      
  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      flash[:success] = "Logged in from #{provider.titleize}!"
      redirect_back_or_to root_url
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        flash[:success] = "Logged in from #{provider.titleize}!"
        redirect_back_or_to root_url
      rescue
        flash[:alert] = "Failed to login from #{provider.titleize}!"
        redirect_back_or_to sign_in_url
      end
    end
  end
end