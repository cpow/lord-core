require 'faker'

FactoryBot.define do
  factory :payment_error do
    
  end
  factory :line_item do
    itemable { create(:expense) }
    company
  end

  factory :expense do
    amount 1200
    company
    description 'MyText'
    expenseable { build(:property) }
  end

  factory :notification_subscription do
    email_new_notifications true
    property_manager
    user
  end

  factory :manual_payment_receipt do
    manual_payment nil
  end

  factory :event_read do
    event
    reader { build(:user) }
  end

  factory :issue_comment do
    issue
    commentable { build(:user) }
    body "MyText"
  end

  factory :issue_image do
    issue nil
  end

  factory :issue do
    property
    unit
    reporter { build(:user) }
    description "Something happened OMG"
    category Issue::ISSUE_CATEGORIES[0]
  end

  factory :event do
    eventable { build(:issue_comment) }
    createable { build(:user) }
    event_type Event::EVENT_CREATED
  end

  factory :message do
    unit nil
    body "MyText"
  end

  factory :charge_event do
    stripe_charge_id "something"
    event_type ChargeEvent::FAILURE_TYPE
    stripe_event_id "MyString"
    failure_code "This is a failure"
    failure_message "Something happened and it failed"
    payment
  end

  factory :admin do
  end

  factory :lease_payment_reminder do
    email_text 'MyText'
    reminder_type LeasePaymentReminder::REMINDER_TYPE_DUE_NOW
    lease_payment
  end

  factory :property_image do
    property_id 1
  end

  factory :lease_payment do
    unit
    lease
    due_date { (Time.zone.now + 10.days).beginning_of_day }
    reminder_date { (Time.zone.now + 2.days).beginning_of_day }
    past_due_date { (Time.zone.now + 15.days).beginning_of_day }
    active true

    trait :late do
      due_date { (Time.zone.now - 10.days).beginning_of_day }
    end

    trait :reminder do
      reminder_date { (Time.zone.now - 5.days).beginning_of_day }
    end

    trait :due_today do
      due_date { (Time.zone.now).beginning_of_day }
    end

    trait :has_been_reminded do
      after(:create) do |instance|
        create(:lease_payment_reminder, lease_payment: instance)
      end
    end
  end

  factory :lease do
    start_date DateTime.parse("2017-12-02")
    end_date DateTime.parse("2018-12-02")
    payment_amount 155000
    payment_first_date DateTime.parse("2017-12-02")
    payment_days_until_late 3
    payment_reminder_days 3
    unit

    trait :with_payment do
      after(:create) do |instance|
        create(:lease_payment, lease: instance)
      end
    end
  end

  factory :payment do
    unit
    user
    stripe_charge_id '123charge'
    latest_event_type ChargeEvent::CREATED_TYPE
    amount 10000

    trait :error do
      latest_event_type ChargeEvent::FAILURE_TYPE
    end

    trait :successful do
      latest_event_type ChargeEvent::SUCCEEDED_TYPE
    end

    trait :pending do
      latest_event_type ChargeEvent::PENDING_TYPE
    end
  end

  factory :residency do
    unit
    property
    company
    user
    active true
  end

  factory :unit do
    property
    description Faker::Hipster.sentence(3)
    name Faker::RickAndMorty.character
  end

  factory :property do
    address_city Faker::Address.city
    address_line1 Faker::Address.street_address
    address_state Faker::Address.state_abbr
    address_postal Faker::Address.postcode
    name Faker::App.name
    description Faker::Hipster.sentence(4)
    company
  end

  factory :stripe_account do
  end

  factory :property_manager do
    name Faker::RickAndMorty.character
    sequence(:email) { |n| "manager#{n}@example.com" }
    password 'test1234'

    trait :with_company do
      company
    end

    trait :with_subscription do
      after(:create) do |instance|
        create(:notification_subscription, property_manager: instance)
      end
    end
  end

  factory :user do
    name Faker::GameOfThrones.character
    sequence(:email) { |n| "tenant#{n}@example.com" }
    password 'test1234'
    password_confirmation 'test1234'

    trait :with_stripe_account do
      stripe_account_guid '123stripe'
    end

    trait :with_subscription do
      after(:create) do |instance|
        create(:notification_subscription, user: instance)
      end
    end

    trait :with_residence do
      after(:create) do |instance|
        company = create(:company, :with_stripe_account)
        property = create(:property, company: company)
        unit = create(:unit, property: property)
        create(:residency,
               property: property,
               unit: unit,
               company: company,
               user: instance)
      end
    end

    trait :with_late_lease_payment do
      after(:create) do |instance|
        property = create(:property)
        unit = create(:unit, property: property)
        create(:residency,
               property: property,
               unit: unit,
               company: property.company,
               user: instance)
        lease = create(:lease, unit: unit)
        create(:lease_payment, :late, unit: unit, lease: lease)
      end
    end

    trait :with_reminder_lease_payment do
      after(:create) do |instance|
        property = create(:property)
        unit = create(:unit, property: property)
        create(:residency,
               property: property,
               unit: unit,
               company: property.company,
               user: instance)
        lease = create(:lease, unit: unit)
        create(:lease_payment, :reminder, unit: unit, lease: lease)
      end
    end

    trait :with_due_lease_payment do
      after(:create) do |instance|
        property = create(:property)
        unit = create(:unit, property: property)
        create(:residency,
               property: property,
               unit: unit,
               company: property.company,
               user: instance)
        lease = create(:lease, unit: unit)
        create(:lease_payment, :due_today, unit: unit, lease: lease)
      end
    end
  end

  factory :company do
    name 'property management company'

    trait :with_stripe_account do
      stripe_account_guid '123stripe'
    end
  end
end
