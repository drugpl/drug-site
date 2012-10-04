Drug::Application.routes.draw do
  root to: "home#index"
  resources :users, only: [:index, :show]

  resources :events, only: [:index, :show] do
    resources :attendants, only: [:index]
  end
  resource :contact, only: [:show, :create]
end
