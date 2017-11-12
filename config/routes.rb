Rails.application.routes.draw do

	get 'root/index'

	root to: 'root#index'

	get '/search/:query' => 'search#index' , as: 'search'
	get '/search?query=:query' => 'search#index' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
