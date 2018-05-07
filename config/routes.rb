Rails.application.routes.draw do
  resources :jobs
  resources :searches
end

Jobs::search do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'jobs#index'
end

get '/index' => 'jobs#index'
