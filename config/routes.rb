Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get "/application.manifest" => Rails::Offline
	root 'home#index'
  get ':controller(/:action(/:id(.:format)))'
  post ':controller(/:action(/:id(.:format)))'
  patch ':controller(/:action(/:id(.:format)))'
	mathjax 'mathjax'
end
