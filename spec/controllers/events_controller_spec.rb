require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET index" do
    it "assigns @events" do
      # création d'une instance
      event = Event.create

      # on va sur index
      get :index

      # @users doit être une array qui contient user
      expect(assigns(:events)).to eq([event])
    end

    it "renders the index template" do
      # va sur index
      get :index

      # on doit rediriger vers index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @events" do
      # création d'une instance
      event = Event.create

      # on va sur show
      get :show, id: event.id

      # @user doit être user
      expect(assigns(:event)).to eq(event)
    end

    it "renders the show template" do
      # va sur show
      get :show

      # on doit rediriger vers show
      expect(response).to render_template("show")
    end
  end


end
