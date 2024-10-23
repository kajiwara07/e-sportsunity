Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
     sessions: 'admin/sessions'
 }

   namespace :admin do
     resources :posts
     resources :users, only: [:destroy]
     resources :comments, only: [:destroy]
     resources :chats, only: [:destroy]
      get 'dashboards', to: 'dashboards#index'
   end
  
 scope module: :public do
  root to: "homes#top"
  get "/homes/about" => "homes#about", as: "about"
  get '/mypage', to: 'users#show', as: 'mypage'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
        resources :comments, only: [:create, :destroy]
        get :search, on: :collection
  end
  resources :notifications, only: [:update]
  resources :chats, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
     resources :chat_messages, only: [:create]
     resources :groups, only: [:create, :destroy]
     
     namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
  end 
 
end