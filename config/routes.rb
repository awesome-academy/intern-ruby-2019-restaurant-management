Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root to: "static_pages#home"
    get "show_booking", to: "bookings#index"
    get "/help", to: "static_pages#help"
    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    resources :discounts
    resources :foods
    resources :menus, except: :show
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
