Rails.application.routes.draw do
	devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tweets#index'
  get 'tweets' , to: 'tweets#index'
  get 'tweets/new', to: 'tweets#new'
  post 'tweets', to: 'tweets#create'
  get 'tweets/edit/:id', to: 'tweets#edit', as: 'tweets_edit'
  get 'tweets/:id', to: 'tweets#show', as: 'tweets_show'  

  #resources :tweets

end
