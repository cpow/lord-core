class NotificationReminderMailer < ApplicationMailer
  def remind_tenant_of_event(user_id, event_id)
    @event = Event.find(event_id)
    @user = User.find(user_id)

    subject = "New Notifcation in your apartment!, #{@event.eventable_type}"
    mail(to: @user.email, subject: subject)
  end

  def remind_manager_of_event(property_manager_id, event_id)
    @event = Event.find(event_id)
    @manager = PropertyManager.find(property_manager_id)

    subject = "New Notifcation in your property!, #{@event.eventable_type}"
    mail(to: @manager.email, subject: subject)
  end
end
