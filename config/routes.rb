# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users
  namespace :users do
    resources :account_activations, only: :edit
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
