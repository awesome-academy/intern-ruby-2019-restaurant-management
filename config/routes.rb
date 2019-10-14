Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root to: "static_pages#home"
    get "static_pages/help"
    devise_for :users
  end
end
