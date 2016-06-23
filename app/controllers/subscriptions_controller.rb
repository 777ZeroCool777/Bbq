class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

 def create
   @new_subscription = @event.subscriptions.build(subscription_params)
   @new_subscription.user = current_user

   if @new_subscription.save
     # Отправляю письмо автору события
     EventMailer.subscription(@event, @new_subscription).deliver_now
     # если сохранилась успешно, редирект на страницу самого события
     redirect_to @event, notice: I18n.t('controllers.subscription.created')
   else
     # если ошибки — рендерю здесь же шаблон события
     render 'events/show', alert: I18n.t('controllers.subscription.error')
   end
 end

  def destroy
    message ={notice: I18n.t('controllers.subscription.destroyed')}

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscription.error')}
    end
    redirect_to @event, message
  end

  private
    def set_subscription
      @subscription = @event.subscriptions.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscription_params
      params.fetch(:subscription, {}).permit(:user_email, :user_name)
    end
end
