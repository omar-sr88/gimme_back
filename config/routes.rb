Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'

  root 'sessions#new'
  get   '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post   '/users/search', to: 'users#search'
  get   '/users/search', to: 'users#search'

  
  resources :items
  get 'items/:f',  to: 'items#index'
  get 'items/:id/return' ,  to: 'items#return' , as: :item_return
  get 'users/:id/display' ,  to: 'users#show' , as: :user_display
  resources :users
 	resources :account_activations, only: [:edit] 
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
