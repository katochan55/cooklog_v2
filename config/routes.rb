Rails.application.routes.draw do
  get 'notifications/index'
  root 'static_pages#home'
  get :about,        to: 'static_pages#about'
  get :use_of_terms, to: 'static_pages#terms'
  get :signup,       to: 'users#new'
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  get :record_dish,  to: 'dishes#new'
  resources :dishes, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  post   "favorites/:dish_id/create"  => "favorites#create"
  delete "favorites/:dish_id/destroy" => "favorites#destroy"
  resources :memos, only: [:create, :destroy]
  resources :notifications, only: :index
end
