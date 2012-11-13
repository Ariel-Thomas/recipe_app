class UsersController < ApplicationController
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
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Error while updating profile"
      render :edit
    end
  end

  def edit
    @user = current_user
  end

  def destroy
    user = current_user
    logout
    user.destroy
  end
end
