Rails.application.routes.draw do
  #root 'about#index'
  resources :exercises
  resources :muscle_groups, only: :show
end
