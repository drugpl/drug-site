Drug::Application.routes.draw do
  resources :sessions, only: [:create] do
    delete 'destroy', on: :collection
  end
  match "/auth/:provider/callback", to: "sessions#create"

  root to: "home#index"
  resources :users, only: [:index, :show]

  resources :events, only: [:index, :show] do
    resources :attendants, only: [:index]
  end
  resource :contact, only: [:show, :create]
end
