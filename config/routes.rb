Rails.application.routes.draw do
  resources :followers

  resources :boards

  resources :users , except: [:index]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pins#index'

 get "pins/name-:slug" => "pins#show_by_name", as: "pin_by_name"
 
 get "pins/name-:slug/edit" => "pins#edit_by_name", as: "edit_pin_by_name"

  resources :pins
  
  get '/library' => 'pins#index'
  get '/users' => 'pins#index'
   #get '/:id/edit', to: 'pins#edit'
  get '/edit', to: 'pins#edit'
  post '/edit', to: 'pins#show'
  post 'pins/repin/:id' => 'pins#repin', as: 'repin'
  
  get '/signup' => 'users#new', as: :signup
  get '/login' => 'users#login', as: :login
  post '/login' => 'users#authenticate'
  delete 'logout/:id' => "users#logout", as: :logout
      


################################### The Last End ###################################
end
