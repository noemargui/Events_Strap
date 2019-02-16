class EventsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit]
  # before_action :author_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.all.reverse
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
    @admin = @event.administrator
  end

  def new
    @event = Event.new
    @user_id = current_user.id
  end

  def create
    @event = Event.new(title: params[:title],
                       description: params[:description],
                       start_date: params[:start_date],
                       duration: params[:duration],
                       price: params[:price],
                       location: params[:location],
                       administrator_id: current_user.id )

    if @event.save # essaie de sauvegarder en base @event
      redirect_to root_path, :notice => "Event créé !"
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    event_params = params.permit(:title, :description)

      if @event.update(event_params)
        # flash[:notice] = "event mis à jour"
        redirect_to @event, :notice => "Event mis à jour"
      else
        render :edit
      end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

    def authenticate_user
      unless current_user
          flash[:danger] = "Connecte-toi ;)"
          redirect_to user_session_path
      end
    end

end
