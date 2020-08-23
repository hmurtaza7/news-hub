Rails.application.routes.draw do

  devise_for :users
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resource :likes, only: [:create, :destroy]
  end

  root 'posts#index'
end
