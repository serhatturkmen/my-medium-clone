Rails.application.routes.draw do

  resources :posts do
    resources :comments, controller: 'comment' do
      get '/accept', to: 'comment#accept', as: 'accept'
    end
  end
  devise_for :users

  get '/homepage', to: 'welcome#index', as: 'welcome'
  get '/users/:id', to: 'welcome#user_page', as: 'welcome_user_page'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  root 'welcome#index'
end
