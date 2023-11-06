Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/admin", to: "admin/dashboard#index"
  get "/admin/invoices", to: "admin/invoices#index"
  get "/admin/invoices/:invoice_id", to: "admin/invoices#show"
  get "/admin/merchants", to: "admin/merchants#index"
  namespace :admin do
    patch '/merchants/:id/disable', to: 'merchants#disable', as: 'merchant_disable'
    patch '/merchants/:id/enable', to: 'merchants#enable', as: 'merchant_enable'
  end
  get "/admin/merchants/:merchant_id", to: "admin/merchants#show"
  get "/admin/merchants/:merchant_id/edit", to: "admin/merchants#edit", as: :edit_merchant
  patch "admin/merchants/:merchant_id", to: "admin/merchants#update", as: :update_merchant

  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/merchants/:merchant_id/items", to: "merchants/items#index"
  get "/merchants/:merchant_id/invoices", to: "merchants/invoices#index"
  



  get "/merchants/:merchant_id/items/:item_id", to: "merchants/items#show"
  get "/merchants/:merchant_id/items/:id/edit", to: "merchants/items#edit", as: :edit_merchant_item
  patch "/merchants/:merchant_id/items/:id", to: "merchants/items#update", as: :update_merchant_item

  patch "/merchants/:merchant_id/items/:id/enable", to: "merchants/items#enable"
  patch "/merchants/:merchant_id/items/:id/disable", to: "merchants/items#disable"

  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchants/invoices#show"
end
