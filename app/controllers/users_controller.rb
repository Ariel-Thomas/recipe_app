class UsersController < AuthorizationController
  skip_before_filter :require_login, only: [:create, :new, :show]

  require 'will_paginate/array'

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Signed up!"
      redirect_to root_url
    else
      flash[:alert] = "Error while creating user"
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @recipes = Recipe.paginate(:page => params[:page] || 1, :per_page => 10).find_all_by_user_id(@user.id)
    @favorites = @user.favorites.map{ |favorite| favorite.recipe }.paginate(:page => params[:page] || 1, :per_page => 10)
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Error while updating profile"
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    user = current_user
    logout
    user.destroy

    flash[:success] = "Profile deleted!"
    redirect_to root_path
  end
end
