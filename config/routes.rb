Rails.application.routes.draw do
  namespace :admin do
      resources :beneficiaries
      resources :cities
      resources :item_categories
      resources :providers
      resources :shoppings
      resources :users
      resources :warehouse_items

      root to: "beneficiaries#index"
    end
  root to: redirect('/sign_in')
end
