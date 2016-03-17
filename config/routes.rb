Rails.application.routes.draw do
  resources :hospital_profiles
  resources :patient_tests
  devise_for :users, :controllers => { registrations: 'registrations'}

  root :to => 'home#index'
  resources :roles
  get '/role/:id/abilities'     => 'roles#change_abilities',  as: :change_role_abilities
  post '/role/:id/update-abilities' => 'roles#update_abilities',  as: :update_role_abilities
  get '/patients' => 'patients#index'
  get '/manage-patient/:id' => 'patients#manage_patient', as: :manage_patient
  patch '/update-patient/:id' => 'patients#update_patient', as: :update_patient
  get '/manage-test/:id' => 'patients#manage_test', as: :manage_test
  post '/update-test/:id' => 'patients#update_test', as: :update_test
  delete '/manage-test/:id/:pid' => 'patients#destroy_test', as: :destroy_test
  get '/manage-profile/:id' => 'patients#show', as: :profile
  get '/edit-profile/:id' => 'patients#edit', as: :edit_profile
  put '/update-profile/:id' => 'patients#update_profile', as: :update_profile
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
