Rails.application.routes.draw do
  root to: 'courses#index'
  devise_for :users, only: [:sessions]

  resources :courses do
  	resources :students, except: :show
	resources :evaluations, except: :show
  end
  
  resources :grades, only: :update

end
