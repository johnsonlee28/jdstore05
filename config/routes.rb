Rails.application.routes.draw do
  resources :subs
  resources :subscribers
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'

  resources :landing_page
  get 'home' => 'products#index'

  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :subs


  resources :products do
    member do
      post :add_to_cart
      post :buynow
      post "like" => "products#like"
      post "unlike" => "products#unlike"
      post "collect" => "products#collect"
      post "uncollect" => "products#uncollect"
    end
    collection do
      get :search
    end

    resources :comments
  end

  resources :carts do
    collection do
      delete :empty
      post :checkout
    end

  end

  resources :orders do
    member do
      post :alipay
      post :wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
  end

  resources :cart_items


end
