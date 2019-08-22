Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, only: %i[new create index]
  get 'users_index', to: 'users#index'
  
  resources :posts, only: %i[new create index show edit update]
  get 'posts_index', to: 'posts#index'
  match '/posts/create', to: 'posts#create', via: :post, as: :create_post


end
