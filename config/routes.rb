Rails.application.routes.draw do
  root "users#index"
  
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments, only:[:new, :create, :destroy]
      resources :likes, only:[:create, :destroy]
    end
  end
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index,:show] do
        resources :posts, only: [:index,:show] do
          resources :comments, only:[:index, :create]
        end
      end
    end
  end
end
