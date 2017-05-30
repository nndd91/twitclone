Rails.application.routes.draw do
	devise_for :users, controllers: { sessions: 'users/sessions' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'tweets' , to: 'tweets#index'
  get 'tweets/new', to: 'tweets#new'
  post 'tweets', to: 'tweets#new'
  root :to => "users/sessions#new"
end
