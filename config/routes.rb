Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do
    resources :invoices, except: [:destroy, :create, :new]
    get "/", to: "dashboard#index"
    patch '/merchants/:id/disable', to: 'merchants#disable', as: :merchant_disable
    patch '/merchants/:id/enable', to: 'merchants#enable', as: :merchant_enable
    resources :merchants, only: [:index, :show, :edit, :update]
  end

  resources :merchants, except: [:destroy, :index, :show, :edit, :update, :new, :create] do
    resources :items, except: [:destroy], controller: 'merchants/items'
    resources :invoices, except: [:destroy, :new, :create], controller: 'merchants/invoices'

    get "/dashboard", to: "merchants#show"

    patch "/items/:id/enable", to: "merchants/items#enable"
    patch "/items/:id/disable", to: "merchants/items#disable"
  end
end