Rails.application.routes.draw do
  resources :grades
  resources :evaluations
  resources :students
  resources :courses
  root to: 'courses#index'
  devise_for :users, only: [:sessions]

  resources :courses do
  	resources :evaluations
  	resources :students
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
