Rails.application.routes.draw do
  root to: 'courses#index'
  devise_for :users, only: [:sessions]

  resources :courses do
  	resources :students
	resources :evaluations, except: :show do
		resources :grades, except: :show
	end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
