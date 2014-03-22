AlmServer::Application.routes.draw do
  resources :beacons, only: [:create], defaults: { format: :json }
end
