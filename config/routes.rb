Rails.application.routes.draw do
  get 'feeds/show'
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :users, only: [:index, :show] do
    resources :relationships, only: [:create, :destroy, :index]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "feeds#show"

  get 'feed', to: 'feeds#show'

  resources :posts do
    resources :comments, only: %i[new create update edit destroy]
    resources :likes, only: [:create, :destroy]
    get 'likes', on: :member
  end

end
