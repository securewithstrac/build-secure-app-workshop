Rails.application.routes.draw do
  root "welcome#index"

  # Allow default routes to support CRUD on address resources
  resources :addresses
  get "/strac-address/new", to: "addresses#strac_new"
  get "/addresses/strac/view", to: "addresses#view"
  post "/addresses/:id/proxy", to: "addresses#proxy_execute"

  resources :personal_identities

  get "/tools/create-token", to: "tools#create_token"
  get "/tools/proxy", to: "tools#proxy"
end
