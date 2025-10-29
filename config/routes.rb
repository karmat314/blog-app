Rails.application.routes.draw do
  post "/register", to: "auth#register"
  post "/login", to: "auth#login"

  # UI pages
  get "/signup", to: "auth#new_register"
  get "/login_page", to: "auth#new_login"

  delete "/logout", to: "auth#logout"


  root "posts#index"  # default page: blog posts list
  resources :posts
end
