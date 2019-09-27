Rails.application.routes.draw do
  authenticated :user do
    root :to => 'posts#index', as: :authenticated_root
  end
  root :to => 'pages#home'
  get 'friendships/create'

  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :users, only: %i[new create index show]
  get 'users_index', to: 'users#index'
  
  resources :posts, only: %i[new create index show edit update]
  get 'posts_index', to: 'posts#index'
  match '/posts/create', to: 'posts#create', via: :post, as: :create_post
  delete '/posts/destroy/:id', to: 'posts#destroy', as: :destroy_post

  match '/likes/create/:id', to: 'likes#create', via: :post, as: :create_like
  delete '/likes/destroy/:id', to: 'likes#destroy', as: :destroy_like

  get 'comments/new'
  match '/comments/create/:id', to: 'comments#create', via: :post, as: :create_comment

  resources :friendships, only: %i[create destroy]
  match '/friendships/update_status/:id', to: 'friendships#update_status', via: :post, as: :update_status
end