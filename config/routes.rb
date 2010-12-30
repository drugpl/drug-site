Drug::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  
  localized('pl') do
    resources :news_articles, :only => [:index, :show]
    resources :events, :only => [:index, :show]
    resource :contact, :only => [:show, :create]
  end
end
