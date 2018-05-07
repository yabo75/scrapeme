Rails.application.routes.draw do
  resources :jobs
  resources :searches
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'jobs#scrapeme'
  get '/scrapeme' => 'jobs#scrapeme'
end
