Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  authenticated :user, -> user { user.has_role?(:admin) }  do
    match "/jobs" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  end

  resources :mailings do
    collection do
      get    'resend'
      get     'pending'
      get     'sending'
      get     'delivered'
      get     'failed'
    end
  end
  resources :messages do
    collection do
      get    'resend'
    end
  end
  resources :tile_tabs
  resources :loads do
    collection do
      get     'tiles'
      get     'details'
    end
  end
  resources :truck_tiles
  resources :load_tiles
  resources :shipper_companies
  resources :carrier_companies
  resources :reminders do
    collection do
      get     'update_from_cable'
      get     'get_current_reminders'
      get     'get_today_reminders'
      get     'notify'
    end
  end
  resources :master_signals, :path => 'signals'
  resources :shipments
  resources :master_invoices, :path => 'invoices'
  resources :mails
  resources :email_templates
  resources :email_links
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
  resources :carrier_notes
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
      get      'show_merge'
      post     'merge'
      get      'partial_merged_table'
      get      'mine'
      post     'delete_new'
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
  resources :planning_sheets do
    collection do
      get     'list'
    end
  end
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
  root 'carriers#index'
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/new',   to: 'users#new',   via: 'get'
  match '/users/:id/edit',   to: 'users#edit',   via: 'get',   as: 'edit_user'
  match '/users/create',   to: 'users#create',   via: 'post'
  match '/users/:id',   to: 'users#show',   via: 'get',   as: 'user'
  match '/users/:id',   to: 'users#update',   via: 'patch'
  match '/users/:id',   to: 'users#update',   via: 'put'
  match '/users/:id',   to: 'users#destroy',   via: 'delete'
  # match '/reminders/:id/notify',   to: 'reminders#notify',   via: 'get'

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
       get      'summaries'
       get      'my_summaries'
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
