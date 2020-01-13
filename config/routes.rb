Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root to: "static_pages#home"
    get "/show_voucher", to: "vouchers#index"
    get "show_booking", to: "bookings#index"
    get "/help", to: "static_pages#help"
    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    resources :comments, only: %i(create destroy)
    resources :foods
    resources :menus, except: :show
    resources :discounts do
      resources :vouchers, shallow: true, only: %i(new create)
    end
    resources :booking, only: [] do
      resources :orders, shallow: true
    end
    resources :tables do
      resources :bookings, only: %i(index new create destroy), shallow: true
    end
    resources :catalogs do
      resources :posts, except: :index, shallow: true
    end
    devise_scope :user do
      get "sign_up", to: "users/registrations#new"
      post "sign_up", to: "users/registrations#create"
      get "login", to: "users/sessions#new"
      post "login", to: "users/sessions#create"
    end
  end
end
