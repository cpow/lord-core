Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :admins

  devise_for :property_managers, path: 'property_managers', controllers: {
    sessions: 'property_managers/sessions',
    registrations: 'property_managers/registrations'
  }

  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  # routes for property managers to see only
  resources :companies
  resources :property_managers
  resources :residencies, only: [:index]
  resources :units do
    resources :messages, only: [:index], controller: 'units/messages'
  end


  # namespaced routes that live within a property's dashboard
  resources :properties do
    resources :units, controller: 'properties/units' do
      resources :leases, controller: 'properties/units/leases'
      resources :residencies, controller: 'properties/units/residencies'
      resources :lease_payments, controller: 'properties/units/lease_payments'
      resources :messages, controller: 'properties/units/messages'
    end

    resources :residencies, controller: 'properties/residencies'
    resources :property_images
  end

  resources :payments
  resources :tenant_plaid_accounts, only: :create
  resources :bank_accounts, only: [:new, :create]
  resources :stripe_accounts


  resources :users do
    resources :leases, only: :show, controller: 'users/leases'
    resources :lease_payments, only: :show, controller: 'users/lease_payments'
  end


  resources :user do
    resources :invitation_acceptances
  end

  namespace :user do
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # Tables from a company's perspective
      resources :units, only: :index
      resources :residencies, only: :index

      # Tables from a property's perspective
      resources :properties, only: [] do
        resources :units, only: :index, controller: :property_units
        resources :residencies, only: :index, controller: :property_residencies
        resources :events, only: :index, controller: :property_events
      end

      resources :units, only: [] do
        resources :messages, only: [:index, :show], controller: :unit_messages
      end

      namespace :stripe do
        namespace :webhooks do
          resources :charges, only: :create
        end
      end
    end
  end

  authenticated :user do
    root 'user_dashboard#show', as: :authenticated_user_root
  end
  authenticated :property_manager do
    root 'high_voltage/pages#show', id: 'property_manager_home', as: :authenticated_property_manager_root
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  HighVoltage.configure do |config|
    config.home_page = 'home'
  end
end
