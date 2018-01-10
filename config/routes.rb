Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :properties do
    resources :residencies
    resources :property_images

    resources :units do
      resources :leases
    end
  end

  resources :payments
  resources :tenant_plaid_accounts, only: :create
  resources :companies
  resources :bank_accounts, only: [:new, :create]
  resources :stripe_accounts

  devise_for :property_managers, path: 'property_managers', controllers: {
    sessions: 'property_managers/sessions',
    registrations: 'property_managers/registrations'
  }

  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users

  resources :user do
    resources :invitation_acceptances
  end

  namespace :user do
    resources :leases, only: [:show]
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
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
