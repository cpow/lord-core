# Preview all emails at http://localhost:3000/rails/mailers/notification_reminder
class NotificationReminderPreview < ActionMailer::Preview
  def remind_tenant_of_event
    NotificationReminderMailer.remind_tenant_of_event(Event.first.id, User.first.id)
  end

  def remind_manager_of_event
    NotificationReminderMailer.remind_manager_of_event(Event.first.id, PropertyManager.first.id)
  end
end
