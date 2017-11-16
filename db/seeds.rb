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
                 first_name: 'chris',
                 admin: true,
                 last_name: 'power',
                 email: 'manager@example.com',
                 password: 'test1234')

manager_without_company = FactoryBot.create(:property_manager,
                                 first_name: 'tophie',
                                 last_name: 'bear',
                                 email: 'managerwithoutcompany@example.com',
                                 password: 'test1234')

tenant = FactoryBot.create(:user,
                first_name: 'tenant tophie',
                last_name: 'powervich',
                email: 'tenant@example.com',
                password: 'test1234'
               )

