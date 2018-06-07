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
  resources :companies do
    resources :finances, only: [:show], controller: 'companies/finances'
  end

  resources :property_manager_creation, only: :create

  resources :expenses do
    get :changing_expenseable_type, on: :member
    get :update_expenseable_type, on: :member
  end
  resources :line_items

  resources :property_managers do
    resource :initializer, only: [:new, :create], controller: 'property_managers/initializer'
    resources :notification_subscriptions, only: [:edit, :update], controller: 'property_managers/notification_subscriptions'
  end
  resources :residencies, only: [:index]
  resources :units do
    resources :messages, only: [:index], controller: 'units/messages'
  end


  # namespaced routes that live within a property's dashboard
  resources :properties do
    resources :units, controller: 'properties/units' do
      resources :leases, controller: 'properties/units/leases'
      resources :residencies, controller: 'properties/units/residencies'
      get 'residency/:id/send_another_invite', to: 'properties/units/residencies#send_another_invite', as: 'send_another_invite'
      resources :lease_payments, controller: 'properties/units/lease_payments'
      resources :messages, controller: 'properties/units/messages'
    end

    resources :residencies, controller: 'properties/residencies'
    resources :issues, controller: 'properties/issues'
    resources :property_images
  end

  resources :lease_payments, only: [] do
    resources :manual_payments
  end

  resources :payments
  resources :payouts
  resources :tenant_plaid_accounts, only: :create
  resources :bank_accounts, only: [:new, :create, :show]
  resources :stripe_accounts


  resources :users do
    resources :leases, only: :show, controller: 'users/leases'
    resources :notification_subscriptions, only: [:update, :edit], controller: 'users/notification_subscriptions'
    resources :lease_payments, only: :show, controller: 'users/lease_payments'
    resources :issues, only: [:index, :new, :create, :show], controller: 'users/issues'
  end

  resources :user do
    resources :invitation_acceptances
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :line_items, only: :index
      # Tables from a company's perspective
      resources :units, only: :index do
        resources :events, only: :index, controller: :unit_events
      end
      resources :residencies, only: :index

      resources :issues, only: :create

      resources :events, only: [] do
        resources :event_reads, only: :create
      end

      # Tables from a property's perspective
      resources :properties, only: [] do
        resources :units, only: :index, controller: :property_units
        resources :residencies, only: :index, controller: :property_residencies
        resources :events, only: :index, controller: :property_events
        resources :issues, only: :index, controller: :property_issues
      end

      resources :units, only: [] do
        resources :messages, only: [:index, :show], controller: :unit_messages
      end

      resources :issues, only: [] do
        resources :issue_comments, only: [:index, :show], controller: :issue_comments
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

  HighVoltage.configure do |config|
    config.home_page = 'home'
  end
end
