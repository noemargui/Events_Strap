class AttendancesController < ApplicationController

  before_action :authenticate_user!
  before_action :only_user, only: [:index]


  def new
    @event = Event.find(params[:event_id])
    @amount = @event.price
  end

  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
  end

  def create
    @event = Event.find(params[:event_id])
    # Amount in cents
    @amount = (@event.price)*100 # *100 à ajouter

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id, # stipe id que je dois récupérer !!! charge[:customer]
      :amount      => @amount,
      :description => 'Paiement du participant', #{@attendee.first_name} #{@attendee.last_name}
      :currency    => 'eur'
    )

    @attendance = Attendance.new(attendee_id: current_user.id, event_id: params[:event_id], stripe_customer_id: customer.id)
    #flash[:success] = "Vous participez à l'évènement"
    #redirect_to @event
    if @attendance.save     
      redirect_to event_path(@event)
      flash[:success] = "Vous participez à l'évènement"
    else
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to event_path

  end

  private

  def only_user
    @event = Event.find(params[:event_id])
    unless current_user == @event.administrator
      redirect_to root_path
      flash[:danger] = "Ce n'est pas votre évènement !"
    end
  end

end
