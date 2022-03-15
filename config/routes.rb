Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  # root                  to: 'movies#index'
  get   '/movies',          to: 'movies#index'
  # get   '/movies/new',      to: 'movies#new'
  post  '/movies',          to: 'movies#create'
  get   '/movies/:id',      to: 'movies#show'
  # get   '/movies/:id/edit', to: 'movies#edit'
  put   '/movies/:id',      to: 'movies#update'
  delete'/movies/:id',      to: 'movies#destroy'

end
