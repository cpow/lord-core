# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot'

manager = FactoryBot.create(:property_manager,
                 :with_company,
                 admin: true,
                 email: 'manager@example.com',
                 password: 'test1234')

property = FactoryBot.create(:property, company: manager.company)

user = FactoryBot.create(
  :user,
  email: 'tenant@example.com',
  password: 'test1234'
)

unit = FactoryBot.create(:unit, property: property)

FactoryBot.create(:residency, user: user, property: property, unit: unit, company: manager.company)

manager_without_company = FactoryBot.create(:property_manager,
                                 email: 'managerwithoutcompany@example.com',
                                 password: 'test1234')

