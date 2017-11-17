FactoryBot.define do
  factory :stripe_account do
    
  end
  factory :property_manager do
    first_name 'chris'
    last_name 'power'
    sequence(:email) { |n| "manager#{n}@example.com" }
    password 'test1234'

    trait :with_company do
      company
    end
  end

  factory :user do
    first_name 'chris'
    last_name 'power'
    sequence(:email) { |n| "tenant#{n}@example.com" }
    password 'test1234'
  end

  factory :company do
    name 'property management company'
  end
end
