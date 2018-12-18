Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'

  root to: 'pages#home'
end
