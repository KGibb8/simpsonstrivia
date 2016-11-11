Rails.application.routes.draw do
  root 'pages#home'
  get '/search' => 'search#index', as: :search
  resources :episodes, only: [:show]
end
