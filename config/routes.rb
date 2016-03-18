Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  resources :users, only: [:show] do
    member do
      get 'my_movies', as: :my_movies
    end
  end
  resources :movies, only: [:index, :create, :show] do
    member do
      post 'vote_for'
      post 'vote_against'
    end
  end
  resources :dashboard, only: [:index]

  scope '(:locale)', :locale => /en|ru/ do
    root 'movies#index'
  end

  get '*path' => redirect('/')
end
