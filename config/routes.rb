Rails.application.routes.draw do
  get 'friendships/create'
  root 'pages#home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, only: %i[new create index show]
  get 'users_index', to: 'users#index'
  
  resources :posts, only: %i[new create index show edit update]
  get 'posts_index', to: 'posts#index'
  match '/posts/create', to: 'posts#create', via: :post, as: :create_post
  match '/likes/create/:id', to: 'likes#create', via: :post, as: :create_like
  delete '/likes/destroy/:id', to: 'likes#destroy', as: :destroy_like

  get 'comments/new'
  match '/comments/create/:id', to: 'comments#create', via: :post, as: :create_comment

end
