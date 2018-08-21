Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'remove', to: 'users#remove', as: :remove_users
  get 'destroy', to: 'users#destroy', as: :destroy_users
  get 'modify', to: 'users#modify', as: :modify_users
  get 'edit', to: 'users#edit', as: :edit_users
end
