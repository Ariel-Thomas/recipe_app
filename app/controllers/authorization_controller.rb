class AuthorizationController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You cannot access that page"
    redirect_to root_url
  end

  protected
  def not_authenticated
    flash[:error] = "Please sign in first"
    redirect_to new_session_path
  end
end

