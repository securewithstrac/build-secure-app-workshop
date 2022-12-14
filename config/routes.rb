Rails.application.routes.draw do
  root "welcome#index"

  # Allow default routes to support CRUD on address resources
  resources :addresses
  get "/strac-address/new", to: "addresses#strac_new"
  get "/addresses/strac/view", to: "addresses#view"

  resources :personal_identities
  get "/strac_pi/new", to: "personal_identities#strac_new"
  get "/strac_pi/view", to: "personal_identities#view"

  post "/tools/proxy-execute", to: "tools#proxy_execute"
  get "/tools/create-token", to: "tools#create_token"
  get "/tools/proxy", to: "tools#proxy"
end
