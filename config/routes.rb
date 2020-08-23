Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :posts, only: [:index, :new, :create, :destroy] do
    resource :likes, only: [:create, :destroy]
  end

  root 'posts#index'
end
