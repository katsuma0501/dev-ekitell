Rails.application.routes.draw do

	get 'root/index'

	root to: 'root#index'
	
	get '/debug' => 'debug#index' , as: 'debug'

	get '/search' => 'search#index' , as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
