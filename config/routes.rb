Rails.application.routes.draw do
  resources :posts do
    collection do
      get 'create', as: :create
    end
  end
end
