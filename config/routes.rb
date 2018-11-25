Rails.application.routes.draw do
  resources :master_signals, :path => 'signals'
  resources :shipments
  resources :master_invoices, :path => "invoices"
  resources :rates
  resources :activity_outcomes
  resources :activities do
    collection do
      post        "quick_create"
      delete  'remove_attachment'
    end
  end
  resources :locations
  resources :reps
  resources :client_contacts
  resources :client_locations
  resources :clients do
    collection do
      get     'origins'
      delete  'remove_attachment'
    end
  end
  resources :carrier_contacts
  resources :carrier_locations
  resources :carriers do
    collection do
      get     'origins'
      delete  'remove_attachment'
    end
  end
  resources :logs
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

 #APIs
 namespace :api do
   resources :locations do
     collection do
       get      'distance'
     end
   end
   resources :clients
   resources :carriers
 end
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlerb
end
