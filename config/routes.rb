Rails.application.routes.draw do
  root 'root#input'
  post 'root/show', as: 'show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
