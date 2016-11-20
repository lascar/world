Rails.application.routes.draw do
  devise_for :users
  root to: 'world#show'
  get '/world', :to => 'world#show'
end
