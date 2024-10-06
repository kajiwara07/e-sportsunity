Rails.application.routes.draw do
  root to: "homes#top"
 
  get "/homes/about" => "homes#about", as: "about"
  get '/mypage', to: 'users#show', as: 'mypage'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
        get :search, on: :collection
  end
  resources :groups, only: [:index, :create, :show, :edit, :update, :destroy]
 
  get 'chats/show', to: 'chats#show'
  
  #devise_for :admin, skip: [:registrations, :password], controllers: {
   # sessions: 'admin/sessions'
  #}
  
  #namespace :admin do
    #resources :posts
   # get 'dashbords', to: 'dashboards#index'
  #end
end