class NotificationSubscription < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :property_manager, optional: true
end
