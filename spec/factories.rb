FactoryBot.define do
  factory :property_manager do
    first_name 'chris'
    last_name 'power'
    email 'manager@example.com'
    password 'test1234'
  end

  factory :user do
    first_name 'chris'
    last_name 'power'
    email 'tenant@example.com'
    password 'test1234'
  end
end
