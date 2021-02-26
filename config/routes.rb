Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :customers, only:[:index, :show] do
      resources :reports, only:[:index, :show]
    end
    resources :requests, only:[:index, :show]
    resources :tickets, except:[:new, :show]
  end


  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }

  get '/' => 'home#top'
  get '/about' => 'home#about'

  namespace :users do
  	resources :customers, except:[:new, :create] do
      resources :reports, only:[:create]
    end
  	resources :requests do
  		resources :participants, only:[:create, :destroy]
  	end
    resources :tickets, only:[:index]
    resources :purchases, only:[:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end