Rails.application.routes.draw do
  namespace :admin do
    resources :beneficiaries do
      member do
        get :confirmation
        put :confirm
        post :deny_confirmation
        get :confirmation_max_shop_count
        put :confirm_max_shop_count
        post :deny_confirmation_max_shop_count
      end
    end
    resources :cities
    resources :item_categories
    resources :providers
    resources :shoppings do
      put :hard_close
      resources :shopping_items do
        collection do
          get :cart
          post :bulk_add
        end
      end
    end
    resources :shopping_items
    resources :users do
      member do
        put :activate
      end
    end
    resources :warehouse_items

    root to: "beneficiaries#index"
  end
  resource :signup_completion, only: [ :new, :create ]
  root to: redirect('/sign_in')
end
