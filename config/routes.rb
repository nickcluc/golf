Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: [:show]

  resources :courses, only: [:new, :index, :create, :show]

  resources :courses, only: [:show] do
    resources :tees, only: [:create]
  end

  resources :rounds, only: [:new, :index, :create, :show]

  resources :rounds, only: [:show] do
    resources :player_rounds, only: [:index, :create]
  end
end
