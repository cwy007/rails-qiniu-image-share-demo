Rails.application.routes.draw do
  resources :likes
  devise_for :users
  resources :posts do
    collection do
      get 'create', as: :create
    end
    resources :likes 
  end

  root 'posts#index'
end
