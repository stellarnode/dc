Rails.application.routes.draw do

  resources   :payments do
    get       '/donate' => 'payments#donate'
  end

  resources   :polls
  match       '/polls/:id/voting' => 'polls#voting', via: [:get], :as => :voting_poll
  post        '/votes' => 'votes#create', via: [:post], :as => :new_votes

  resources   :comments

  resources   :posts
  match       'posts/category' => 'posts#set_category', via: [:post], :as => :set_category

  resources		:profiles, only: [:show, :edit, :update ]
  resources 	:flats
  resources   :chat_messages

  devise_for 	:users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  resources   :users do
    resources :emails, only: [:index, :show, :new, :create, :destroy]
  end

  match 		  '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  root 			  'welcome#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'

end
