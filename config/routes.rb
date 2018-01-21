Rails.application.routes.draw do
  
  root 'pictures#index'

  resources :pictures
  
  resources :users, only: [:new, :create, :show, :update, :edit]
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
