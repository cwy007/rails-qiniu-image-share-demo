Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    collection do
      get 'create', as: :create
    end
  end

  root 'posts#index'
end
