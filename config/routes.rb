Spree::Core::Engine.routes.draw do
	namespace :admin do

		resources :code_groups
		resources :promotion_codes


  end
end
