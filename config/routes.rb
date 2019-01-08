Rails.application.routes.draw do
  resources :master_signals, :path => 'signals'
  resources :shipments
  resources :master_invoices, :path => 'invoices'
  resources :activities do
    collection do
      post    'quick_create'
      delete  'remove_attachment'
    end
  end
  resources :rates
  resources :reps, :path => 'stewards'
  resources :carrier_activities do
    collection do
      post    'quick_create'
      delete  'remove_attachment'
    end
  end
  resources :carrier_lanes
  resources :carrier_contacts
  resources :carrier_locations
  resources :carrier_rates
  resources :carriers do
    collection do
      get     'origins'
      delete  'remove_attachment'
    end
  end
  resources :shipper_activities do
    collection do
      post    'quick_create'
      delete  'remove_attachment'
    end
  end
  resources :shipper_lanes
  resources :shipper_contacts
  resources :shipper_locations
  resources :shipper_rates
  resources :shippers do
    collection do
      get     'origins'
      delete  'remove_attachment'
    end
  end
  resources :logs
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    authenticated :user do
      root 'carriers#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/new',   to: 'users#new',   via: 'get'
  match '/users/:id/edit',   to: 'users#edit',   via: 'get',   as: 'edit_user'
  match '/users/create',   to: 'users#create',   via: 'post'
  match '/users/:id',   to: 'users#show',   via: 'get',   as: 'user'
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
   resources :carrier_contacts
   resources :shipper_contacts
 end
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlerb
end
