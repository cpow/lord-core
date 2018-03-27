class CreateNotificationSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :property_manager, foreign_key: true
      t.boolean :email_new_notifications, default: true
      t.datetime :last_email_notification_reminder_date

      t.timestamps
    end
  end
end
