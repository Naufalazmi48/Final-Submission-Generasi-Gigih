Rails.application.routes.draw do
  get 'orders/customer_id'
  get 'orders/date'
  get 'orders/status'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, only: [:index, :show, :update, :destroy, :create]
  resources :categories, only: [:index, :show, :update, :destroy, :create]
  resources :orders, only: [:index, :show, :update, :destroy, :create] do
    post :paid, on: :member
    get :history, on: :collection
  end
  
end
