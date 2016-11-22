Rails.application.routes.draw do
  #resources :companies
  #resources :students
  #resources :appointments
  #resources :events
  resources :timeslots
  get 'useradds/new'

  resources :useradds
  resources :sessions
  
  resources :students do
    collection do
      post 'remove_all'
    end
  end
  resources :companies do
    collection do
      post 'remove_all'
    end
  end
  resources :events do
    collection do
      post 'remove_all'
    end
  end
  resources :appointments do
    collection do
      post 'remove_all'
    end
  end
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  
  get 'signup' => 'useradds#new'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'sessions#new'
  
  get '/del' => 'sessions#del'
  get '/generate' => 'appointments#generate'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
