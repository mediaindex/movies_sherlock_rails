Rails.application.routes.draw do
  get '/sign_up' => 'users#new', as: :sign_up
  get '/sign_in' => 'user_sessions#new', as: :sign_in
  delete '/sign_out' => 'user_sessions#destroy', as: :sign_out

  resources :users do
    member do
      get 'my_movies', as: :my_movies
    end
  end
  resources :movies
  resources :user_sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]


  scope '(:locale)', :locale => /en|ru/ do
    root 'movies#index'
  end
end
