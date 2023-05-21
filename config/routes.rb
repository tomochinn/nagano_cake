Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
    resources :items, only: [:index, :show]
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/quit' => 'customers#quit'
    patch 'customers/deactive' => 'customers#deactive'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items' => 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders' => 'orders#confirm'
    get 'orders' => 'orders#thanks'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
