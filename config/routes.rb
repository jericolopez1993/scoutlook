Rails.application.routes.draw do
  resources :client_contacts
  resources :reps
  resources :locations
  resources :clients
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'dashboards#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end 
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlerb
end
