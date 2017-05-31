Rails.application.routes.draw do
	devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tweets#index'
  get 'profile/', to: 'profile#index'  
  get 'profile/home/', to: 'profile#home'
  get 'profile/:user_id/following', to: 'profile#following', as: 'following'
  get 'profile/:user_id/followers', to: 'profile#followers', as: 'follower'
  get 'profile/:user_id', to: 'profile#show', as: 'profile_show'
  get 'profile/:user_id/follow', to: 'profile#follow', as: 'follow'
  get 'profile/:user_id/unfollow', to: 'profile#unfollow', as: 'unfollow'
  resources :tweets

end
