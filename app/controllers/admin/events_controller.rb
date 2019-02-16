class Admin::EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_if_admin

  def index
    @events = Event.all.reverse
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
    @admin = @event.administrator
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    event_params = params.permit(:title, :description)

      if @event.update(event_params)
        # flash[:notice] = "event mis à jour"
        redirect_to admin_event_path, :notice => "Event mis à jour"
      else
        render :edit
      end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path
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
