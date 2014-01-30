Drug::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "home#index"

  namespace :api do
    resources :events do
      resources :presentations
    end
  end

  resources :events, only: [:index, :show] do
    resources :attendants, only: [:index]
  end
  resources :presentations, only: [:index]

  # translated routes in PL
  scope do
    resources :events, only: [:index, :show], path: 'spotkania' do
      resources :attendants, only: [:index], path: 'uczestnicy'
    end
  end
end
