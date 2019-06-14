Rails.application.routes.draw do
   mount ActionCable.server => '/cable'
  resources :mailings do
    collection do
      get    'resend'
    end
  end
  resources :messages do
    collection do
      get    'resend'
    end
  end
  resources :tile_tabs
  resources :truck_tiles
  resources :load_tiles
  resources :shipper_companies
  resources :carrier_companies
  resources :reminders
  resources :master_signals, :path => 'signals'
  resources :shipments
  resources :master_invoices, :path => 'invoices'
  resources :mails
  resources :activities do
    collection do
      post    'quick_create'
      delete  'remove_attachment'
      get     'generate_pdf'
    end
  end
  resources :rates do
    collection do
      get     'generate_pdf'
    end
  end
  resources :reps, :path => 'stewards'
  resources :carrier_lanes
  resources :carrier_contacts
  resources :carrier_locations
  resources :carriers do
    collection do
      get     'origins'
      delete  'remove_attachment'
      post     'compose_mail'
      post     'send_mail'
      post     'compose_sms'
      post     'send_sms'
      get      'prom'
      get      'demo'
      get      'newly'
    end
  end
  resources :shipper_lanes
  resources :shipper_contacts
  resources :shipper_locations
  resources :shippers do
    collection do
      get     'origins'
      delete  'remove_attachment'
      post     'compose_mail'
      post     'send_mail'
      post     'compose_sms'
      post     'send_sms'
    end
  end
  resources :logs
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
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
   resources :mailings do
     collection do
       post      'delete_mails'
       post      'update_mails'
     end
   end
   resources :messages do
     collection do
       post      'delete_messages'
       post      'update_messages'
       post      'receive'
     end
   end
   resources :clients
   resources :carriers do
     collection do
       get      'check_mc_number'
     end
   end
   resources :carrier_contacts
   resources :shipper_contacts
   resources :activities
   resources :load_tiles
   resources :truck_tiles
   resources :users
 end
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlerb
end
