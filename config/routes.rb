Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root to: "static_pages#home"
    get "static_pages/help"
    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    devise_scope :user do
      get "sign_up", to: "users/registrations#new"
      post "sign_up", to: "users/registrations#create"
    end
  end
end
