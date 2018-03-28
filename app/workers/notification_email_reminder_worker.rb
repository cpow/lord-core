class NotificationEmailReminderWorker
  include Sidekiq::Worker

  attr_accessor :users, :managers

  def perform(event_id)
    @event = Event.find(event_id)
    unread = Notifications::Unread.new(@event)
    @users = unread.users
    @managers = unread.managers

    mail_to_users if @users
    mail_to_managers if @managers
  end

  def mail_to_users
    @users.each do |user|
      NotificationReminderMailer
        .remind_tenant_of_event(user.id, @event.id)
        .deliver_later
    end
  end

  def mail_to_managers
    @managers.each do |manager|
      NotificationReminderMailer
        .remind_manager_of_event(manager.id, @event.id)
        .deliver_later
    end
  end
end
