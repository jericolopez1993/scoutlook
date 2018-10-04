Rails.application.routes.draw do
  resources :shipments
  resources :master_invoices
  resources :rates
  resources :activity_outcomes
  resources :activities do
    collection do
      post        "quick_create"
    end
  end
  resources :locations
  resources :client_contacts
  resources :reps
  resources :client_locations do
    collection do
      get     'origin_destination'
    end
  end
  resources :clients
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    authenticated :user do
      root 'dashboards#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id/edit',   to: 'users#edit',   via: 'get'
  match '/users/:id',   to: 'users#show',   via: 'get'
  match '/users/:id',   to: 'users#update',   via: 'patch'
  match '/users/:id',   to: 'users#update',   via: 'put'
  match '/users/:id',   to: 'users#destroy',   via: 'delete'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlerb
end
