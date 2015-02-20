Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users

  resources :courses, only: [:new, :index, :create, :show]
  resources :courses, only: [:show] do
    resources :tees, only: [:create]
  end
end
