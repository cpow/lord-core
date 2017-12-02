require 'faker'

FactoryBot.define do
  factory :lease do
    start_date "2017-12-02 15:18:24"
    end_date "2017-12-02 15:18:24"
    payment_amount 1
    payment_due_day_of_month 1
    payment_days_until_late 1
    unit_id 1
  end
  factory :payment do
    amount 1
    amount_refunded 1
    unit_id 1
    user_id 1
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
