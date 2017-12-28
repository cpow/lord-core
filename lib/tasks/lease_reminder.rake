namespace :lease_reminder do
  desc "TODO"
  task due_soon: :environment do
    LeasePayment::RemindUsers.rent_is_coming_up
  end

  desc "TODO"
  task due_now: :environment do
    LeasePayment::RemindUsers.rent_is_due
  end
end
