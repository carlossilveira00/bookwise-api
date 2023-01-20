Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'member_details', to: 'members#index'

  resources :books, only: [:index, :show, :create]

  # Cant use the resources to generate the index route because my index action should have an user_id in the params
  # and the index route when generated with resources don't accept params.
  get 'user_library/:id', to: 'user_libraries#index'
  post 'user_library', to: 'user_libraries#create'
  patch 'user_library/:id', to: 'user_libraries#update_status'
  delete 'user_library/:id', to: 'user_libraries#destroy'
  #Notes routes
  get 'notes/:id', to: 'notes#index'
  get 'note/:id', to: 'notes#show'
  post 'notes', to: 'notes#create'

end
