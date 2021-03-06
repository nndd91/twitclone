Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tweets#home'

  get 'mentions/create'
  get 'mentions/destroy'

  resources :tweets do
    member do
      resources :reply
      get 'retweet'
      get 'retweeting'
      post 'reply/new' => 'reply#new', :as=>"new_reply"
    end
    collection do # collection instead of member so url = tweets/feed instead of tweets/:id/feed
      get :feed
      get :theme
    end
    resources :likes, only: [:create, :destroy], shallow: true
    resources :images, only: [:create, :destroy], shallow: true
  end

  resources :tags

  resources :message do
    collection do
      get :close
    end
  end

  post 'message/new' => 'message#create', :as=>"create_message"

  resources :profile, only: [:show] do
    member do
      get :get_following
      get :get_followers
    end
    collection do
      get :search
      post :search
    end
    resources :followings, only: [:create, :destroy], shallow: true
    # shallow: true to reduce url length, also profile_id is redundant in delete.
  end

end
