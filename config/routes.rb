Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/aqui'

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, only: %i[new create index]
  get 'user_index', to: 'users#index'
  
  resources :posts, only: %i[new create index]
  get 'post_index', to: 'post#index'

end
