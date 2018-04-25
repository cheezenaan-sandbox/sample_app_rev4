# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users
  namespace :users do
    resources :account_activations, only: :edit
    resources :password_resets, only: %w[new create edit update]
  end

  resources :microposts, only: %w[create destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
