Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy do
    resources :posts, only: :create
  end
  resources :posts, except: :create do
    resources :comments
    member do
      post 'downvote'
      post 'upvote'
    end
  end
  
  resources :comments, only: [:create, :show] do
    member do
      post 'downvote'
      post 'upvote'
    end
  end
end
