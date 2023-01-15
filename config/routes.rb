Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'member_details', to: "members#index"

  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
  post '/books', to: 'books#create'

  # Defines the root path route ("/")
  # root "articles#index"
end
