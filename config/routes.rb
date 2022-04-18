Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, only: [:index, :show, :update, :destroy]
  resources :categories, only: [:index, :show, :update, :destroy]
end
