class Admin::AdminsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_if_admin

  def index
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
