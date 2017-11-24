Rails.application.routes.draw do
  resources :properties do
    resources :units
    resources :residencies
  end

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

  authenticated :user do
    root 'high_voltage/pages#show', id: 'user_home', as: :authenticated_user_root
  end

  authenticated :property_manager do
    root 'high_voltage/pages#show', id: 'property_manager_home', as: :authenticated_property_manager_root
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  HighVoltage.configure do |config|
    config.home_page = 'home'
  end
end
