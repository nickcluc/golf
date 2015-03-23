Rails.application.routes.draw do

  authenticated :user do
    root to: "users#show", as: :authenticated_root
  end

  root to: 'homes#index'

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  resources :users, only: [:show, :index]

  resources :friendships, only: [:create, :update, :destroy]

  resources :courses, only: [:new, :index, :create, :show]

  resources :users, only: :show do
    resources :friendships, only: :index
    resources :posts, only: :create
    resources :rounds, only: :create
    resources :courses, only: :create
  end

  resources :courses, only: :show do
    resources :tees, only: :create
  end


  resources :rounds, only: [:new, :index, :create, :show]

  resources :rounds, only: :show do
    resources :player_rounds, only: [:index, :create]
  end
end
