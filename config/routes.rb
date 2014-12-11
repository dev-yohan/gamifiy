Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/dashboard', as: 'rails_admin'
  devise_for :admins
  devise_for :users

  root 'home#index'

  #apps namespace
  match 'applications' => 'applications/apps#index', :as => :applications_list, :via => :get
  match 'application/:id' => 'applications/apps#show', :as => :application_show, :via => :get
  match 'applications/create' => 'applications/apps#create', :as => :application_create, :via => :get
  match 'applications/new' => 'applications/apps#new', :as => :application_new, :via => :post
  match 'applications/edit/:id' => 'applications/apps#edit', :as => :application_edit, :via => :get
  match 'applications/update/:id' => 'applications/apps#update', :as => :application_update, :via => :post
  match 'applications/delete/:id' => 'applications/apps#delete', :as => :application_delete, :via => :get
  match 'applications/destroy/:id' => 'applications/apps#destroy', :as => :application_destroy, :via => :get

  #activities namespace
  match 'activities' => 'activities/activity#index', :as => :activities_list, :via => :get
  match 'activity/:app_id/:id' => 'activities/activity#show', :as => :activity_detail, :via => :get 
  match 'activity/create' => 'activities/activity#create', :as => :activity_create, :via => :get
  match 'activity/new' => 'activities/activity#new', :as => :activity_new, :via => :post
  match 'activity-behavior/:id' => 'activities/activity#behavior_data', :as => :activity_behavior_data, :via => :get 
  match 'weekly-activity-behavior/(:id)' => 'activities/activity#weekly_behavior_data', :as => :weekly_activity_behavior_data, :via => :get

  #badges namespace
  match 'badges' => 'badges/badge#index', :as => :badges_list, :via => :get
  match 'badges/create' => 'badges/badge#create', :as => :badge_create, :via => :get
  match 'badges/new' => 'badges/badge#new', :as => :badge_new, :via => :post
  
  #subjects namespace
  match 'subjects' => 'subjects/subject#index', :as => :subjects_list, :via => :get

  #API V1
  match "api/v1/apps" => "api/v1/apps#index", :as => :api_v1_apps_list, :via => :get
  match "api/v1/apps/:id" => "api/v1/apps#show", :as => :api_v1_app_detail, :via => :get
  match "api/v1/app_activities/:id" => "api/v1/app_activities#index", :as => :api_v1_app_activities, :via => :get

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
