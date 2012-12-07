Drug::Application.routes.draw do
  
  resources :sessions, only: [:create] do
    delete 'destroy', on: :collection
  end
  match "/auth/:provider/callback", to: "sessions#create"

  resources :users, only: [:index, :show] do
    collection do
      get 'edit'
      get 'change_membership'
    end
  end

  resources :events, only: [:index, :show] do

    resources :attendants, only: [:index, :create] do
      delete 'destroy', on: :collection
    end

    resources :presentations, only: [:create, :destroy] do
      member do
        post 'cancel_postponement'
        post 'postpone'
      end
    end

  end

  resource :contact, only: [:show, :create]

  root to: "home#index"
end
