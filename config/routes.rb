Rails.application.routes.draw do
  get  '/auth/:provider/callback', to:'sessions#callback'
  post '/auth/:provider/callback', to: 'sessions#callback'
  get  '/auth/failure' => 'sessions#failure'
  get  '/logout' => 'sessions#destroy'

  resources :home, only: [:index]
  resources :books, shallow: true  do
    collection do
      get 'search'
    end

    resources :reviews
  end

  root to: 'home#index'
end
