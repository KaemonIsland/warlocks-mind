Rails.application.routes.draw do
  resources :users do
    resources :properties, shallow: true, except: [:show]
    resources :damage_types, shallow: true, except: [:show]
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'

  root to: 'pages#home'
end
