Rails.application.routes.draw do
  resources :users do
    resources :properties, shallow: true, except: [:show]
    resources :damage_types, shallow: true, except: [:show]
    resources :weapons, shallow: true do
      resources :weapon_feats, shallow: true, except: [:show, :index]
    end
  end
  delete 'remove/:id/:attr/:index', to: 'weapons#remove_attribute', as: 'remove'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'

  root 'pages#home'
end
