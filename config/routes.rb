Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	devise_for :users, controllers: { registrations: 'users/registrations'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tweets#index'

  resources :tweets do
    collection do # collection instead of member so url = tweets/feed instead of tweets/:id/feed
      get :feed
    end
    resources :likes, only: [:create, :destroy], shallow: true
    resources :images, only: [:create, :destroy], shallow: true
  end

  resources :message
  post 'message/new' => 'message#create', :as=>"create_message"

  resources :profile, only: [:show] do
    member do
      get :get_following
      get :get_followers
    end
    resources :followings, only: [:create, :destroy], shallow: true

    # shallow: true to reduce url length, also profile_id is redundant in delete.
  end

end
