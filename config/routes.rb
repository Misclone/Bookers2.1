Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :users, only: [:new,:index,:show, :update, :edit]
  resources :books, only: [:new, :create, :index, :show, :destroy,:edit,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  get '/home/about' => 'homes#about', as: 'about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
