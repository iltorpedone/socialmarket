Rails.application.routes.draw do
  namespace :admin do
      resources :beneficiaries do
        member do
          get :confirmation
          put :confirm
          post :deny_confirmation
        end
      end
      resources :cities
      resources :item_categories
      resources :providers
      resources :shoppings do
        resources :shopping_items
      end
      resources :shopping_items
      resources :users
      resources :warehouse_items

      root to: "beneficiaries#index"
    end
  root to: redirect('/sign_in')
end
