Rails.application.routes.draw do

  get 'user_detail/:id', to: 'users#show', as: 'user_detail'
  get 'users/feed', to: 'users#feed', as: 'user_feed'

  resources :posts do
    patch :vote_add, on: :member
    patch :vote_reduce, on: :member
    resources :comments, controller: 'comment' do
      get '/accept', to: 'comment#accept', as: 'accept'
    end
  end
  devise_for :users

  get '/homepage', to: 'welcome#index', as: 'welcome'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  root 'welcome#index'
end
