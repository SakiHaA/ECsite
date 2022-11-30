Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items,  only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_products, only: [:update]
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :addresses,  only: [:index, :create, :edit, :update, :destroy]
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'pre_out'
        patch 'out'
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get 'confirm'
        post 'confirm'
        get 'complete'
      end
    end

    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'clear_all'
      end
    end
  end

end