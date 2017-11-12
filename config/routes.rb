Rails.application.routes.draw do

	get 'root/index'

	root to: 'root#index'

	get '/search?query=:word', to: redirect('/search/%{word}')
	get '/search/:query' => 'search#index' , as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
