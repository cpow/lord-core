class PropertyManagers::NotificationSubscriptionsController < ApplicationController
  before_action :authenticate_property_manager!

  def edit
    @subscription = current_property_manager.notification_subscription
  end

  def update
    @subscription = current_property_manager.notification_subscription
    if @subscription.update(notification_subscription_params)
      redirect_to edit_property_manager_path(current_property_manager),
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
