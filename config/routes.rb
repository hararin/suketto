Rails.application.routes.draw do
  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }

  get '/' => 'home#top'

  namespace :users do
  	resources :customers, except:[:new, :create]
  	resources :requests do
  		resources :participants, only:[:create, :destroy]
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
