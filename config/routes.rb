Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/aqui'

  devise_for :users, :controllers => { registrations: 'registrations' }
end
