Rails.application.routes.draw do
  root to: 'home#about'
  resources :exercises
  resources :exercises_cardio_exercise, controller: :exercises
  resources :exercises_resistance_exercise, controller: :exercises
  resources :muscle_groups, only: :show
  resources :workouts, only: [:index, :new, :show, :create, :destroy]
end
