class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_if_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user_params = params.permit(:first_name, :last_name, :description)
    @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to admin_users_path, :notice => "Profil mis à jour"
      else
        render :show
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def authenticate_user
    unless current_user
        flash[:danger] = "Connecte-toi ;)"
        redirect_to user_session_path
    end
  end

  def check_if_admin
    unless current_user.is_admin == true
      redirect_to root_path
      flash[:danger] = "Vous n'êtes pas admin !"
    end
  end

end
