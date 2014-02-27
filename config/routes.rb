FiveStringFailWhale::Application.routes.draw do
  resources :tweets
  get '/tweet-search' => 'tweets#search', defaults: {format: 'js'}
  root :to => 'tweets#index'
end
