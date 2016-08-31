Rails.application.routes.draw do
  get 'home/index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'home#index'
  get ':controller(/:action(/:id(.:format)))'
  post ':controller(/:action(/:id(.:format)))'
end
