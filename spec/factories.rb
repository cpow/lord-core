require 'faker'

FactoryBot.define do
  factory :property_image do
    property_id 1
  end

  factory :lease_payment do
    unit
    lease
    due_date (Time.zone.now + 10.days).beginning_of_day
    reminder_date (Time.zone.now + 2.days).beginning_of_day
    past_due_date (Time.zone.now + 15.days).beginning_of_day
    active true
  end

  factory :lease do
    start_date DateTime.parse("2017-12-02")
    end_date DateTime.parse("2018-12-02")
    payment_amount 1550
    payment_first_date DateTime.parse("2017-12-02")
    payment_days_until_late 3
    payment_reminder_days 3
    unit

    trait :with_payment do
      lease_payment
    end
  end

  factory :payment do
    unit
    user
    amount 10000
  end

  factory :residency do
    unit
    property
    company
    user
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
  end

  factory :user do
    name Faker::GameOfThrones.character
    sequence(:email) { |n| "tenant#{n}@example.com" }
    password 'test1234'
  end

  factory :company do
    name 'property management company'
  end
end
