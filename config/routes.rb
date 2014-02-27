FiveStringFailWhale::Application.routes.draw do
  resources :tweets
  get '/tweet-search' => 'tweets#search', defaults: {format: 'json'}
  root :to => 'tweets#index'
end
