Rails.application.routes.draw do
<<<<<<< c65d84319136b527064b62d2ee7800b69e046ace
  scope "(:locale)", locale: /en/ do
    root to: "static_pages#home"
    get "static_pages/help"
    devise_for :users
  end
=======
  root to: "static_pages#home"
  get "static_pages/help"
  devise_for :users
>>>>>>> init model user
end
