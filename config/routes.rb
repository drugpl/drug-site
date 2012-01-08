Drug::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: "home#index"

  resources :events, only: [:index, :show] do
    resources :attendants, only: [:index]
  end
  resource :contact, only: [:show, :create]

  # translated routes in PL
  scope do
    resources :events, only: [:index, :show], path: 'spotkania' do
      resources :attendants, only: [:index], path: 'uczestnicy'
    end
    resource :contact, only: [:show, :create], path: 'kontakt'
  end
end
