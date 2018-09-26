Rails.application.routes.draw do
  resources :activity_outcomes
  resources :activities
  resources :locations
  resources :client_contacts
  resources :reps
  resources :client_locations
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
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlerb
end
