class Users::NotificationSubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @subscription = current_user.notification_subscription
  end

  def update
    @subscription = current_user.notification_subscription
    if @subscription.update(notification_subscription_params)
      redirect_to edit_user_path(current_user),
                  notice: 'subscription successfully updated!'
    else
      render :edit
    end
  end

  private

  def notification_subscription_params
    params.require(:notification_subscription).permit(:id, :email_new_notifications)
  end
end
