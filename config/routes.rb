# -*- encoding : utf-8 -*-
Masquerade::Application.routes.draw do
  scope "(:locale)", :locale => /en|fr/ do
    resource :account do
      get :activate
      get :password
      put :change_password
      
      resources :personas do
        resources :properties
      end
      resources :sites do
        resources :release_policies
      end
      resource :yubikey_association
    end

    resource :session
    resource :password
    
    get "/contact" => "info#contact"
    get "/help" => "info#help", :as => :help
    get "/search" => "info#search"
    get "/safe-login" => "info#safe_login", :as => :safe_login
    
    get "/forgot_password" => "passwords#new", :as => :forgot_password
    get "/reset_password/:id" => "passwords#edit", :as => :reset_password

    get "/login" => "sessions#new", :as => :login
    get "/logout" => "sessions#destroy", :as => :logout

    match "/server" => "server#index", :as => :server
    match "/server/decide" => "server#decide", :as => :decide
    match "/server/proceed" => "server#proceed", :as => :proceed
    match "/server/complete" => "server#complete", :as => :complete
    match "/server/cancel" => "server#cancel", :as => :cancel
    get "/server/seatbelt/config.:format" => "server#seatbelt_config", :as => :seatbelt_config
    get "/server/seatbelt/state.:format" => "server#seatbelt_login_state", :as => :seatbelt_state

    get "/consumer" => "consumer#index", :as => :consumer
    post "/consumer/start" => "consumer#start", :as => :consumer_start
    match "/consumer/complete" => "consumer#complete", :as => :consumer_complete

    get "/:account.:format" => "accounts#show", :as => :formatted_identity
    get "/:account" => "accounts#show", :as => :identity
  end

  root :to => "info#index"
end
