# == Schema Information
#
# Table name: notification_subscriptions
#
#  id                                    :bigint(8)        not null, primary key
#  user_id                               :bigint(8)
#  property_manager_id                   :bigint(8)
#  email_new_notifications               :boolean          default(TRUE)
#  last_email_notification_reminder_date :datetime
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#

require 'rails_helper'

RSpec.describe NotificationSubscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
