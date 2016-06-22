class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_event, only: [:show]
  before_action :set_current_user_event, only: [:edit, :update, :destroy]

  # before_action :pincode_guard!, only: [:show]

  # GET /events
  def index
    @events = Event.all
  end

  # def set_event
  #   @event = Event.find(params[:id])
  # end

  # GET /events/1
  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.update')
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroy')
  end

  private

  # def pincode_guard
  #   return if @event.pincode.blank?
  #   return if user_signed_in? && current_user == @event.user
  #
  #   if @event.pincode == params[:pincode]
  #     cookies.permanent["event_#{event.id}_pincode"] == params[:pincode]
  #   end
  #
  #   if cookies.permanent["events_#{event.id}_pincode"] !=event.pincode
  #     flash.now[:alert] = "Wrong pincode" if params[:pincode].present?
  #     render 'pincode_from'
  #
  #   end
    def set_current_user_event
      @event = current_user.events.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :address, :datetime, :description)
    end
  end


