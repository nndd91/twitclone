Rails.application.routes.draw do
	devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'tweets#index'
  
  resources :tweets do
    collection do # collection instead of member so url = tweets/feed instead of tweets/:id/feed
      get :feed 
    end
  end
  
  resources :profile, only: [:show] do
    member do
      get :get_following
      get :get_followers
    end
    resources :followings, only: [:create, :destroy], shallow: true 
    # shallow: true to reduce url length, also profile_id is redundant in delete.
  end

end
