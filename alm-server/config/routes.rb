AlmServer::Application.routes.draw do
  resources :beacons, only: [:create], defaults: { format: :json }
  resources :questions, only: [:create], defaults: { format: :json }
  resources :matches, only: [:create], defaults: { format: :json }
end
