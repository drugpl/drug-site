Drug::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "home#index"

  resources :events, only: [:index, :show] do
    resources :attendants, only: [:index]
  end
  resource :contact, only: [:show, :create]
  resources :presentations, only: [:index]

  # translated routes in PL
  scope do
    resources :events, only: [:index, :show], path: 'spotkania' do
      resources :attendants, only: [:index], path: 'uczestnicy'
    end
    resource :contact, only: [:show, :create], path: 'kontakt'
  end
end
