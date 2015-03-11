Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin_dashboard', as: 'rails_admin'
  devise_for :admins
  devise_for :users

  root 'brand/home#index'

  match 'dashboard' => 'home#index', :as => :dashboard , :via => :get

  #apps namespace
  match 'applications' => 'applications/apps#index', :as => :applications_list, :via => :get
  match 'application/:id' => 'applications/apps#show', :as => :application_show, :via => :get
  match 'applications/create' => 'applications/apps#create', :as => :application_create, :via => :get
  match 'applications/new' => 'applications/apps#new', :as => :application_new, :via => :post
  match 'applications/edit/:id' => 'applications/apps#edit', :as => :application_edit, :via => :get
  match 'applications/update/:id' => 'applications/apps#update', :as => :application_update, :via => :post
  match 'applications/delete/:id' => 'applications/apps#delete', :as => :application_delete, :via => :get
  match 'applications/destroy/:id' => 'applications/apps#destroy', :as => :application_destroy, :via => :get
  match 'applications/activities/:id' => 'applications/apps#show_activities', :as => :application_activities, :via => :get
  match 'applications/events/:id' => 'applications/apps#show_events', :as => :application_events, :via => :get
  match 'applications/badges/:id' => 'applications/apps#show_badges', :as => :application_badges, :via => :get
  match 'applications/subjects/:id' => 'applications/apps#show_subjects', :as => :application_subjects, :via => :get

  #activities namespace
  match 'activities' => 'activities/activity#index', :as => :activities_list, :via => :get
  match 'activity/show/:app_id/:id' => 'activities/activity#show', :as => :activity_detail, :via => :get
  match 'activity/create' => 'activities/activity#create', :as => :activity_create, :via => :get
  match 'activity/new' => 'activities/activity#new', :as => :activity_new, :via => :post
  match 'activities/edit/:id' => 'activities/activity#edit', :as => :activity_edit, :via => :get
  match 'activities/update/:id' => 'activities/activity#update', :as => :activity_update, :via => :post
  match 'activity/delete/:id' => 'activities/activity#delete', :as => :activity_delete, :via => :get
  match 'activity/destroy/:id' => 'activities/activity#destroy', :as => :activity_destroy, :via => :get
  match 'activity-behavior/:id' => 'activities/activity#behavior_data', :as => :activity_behavior_data, :via => :get
  match 'weekly-activity-behavior/(:id)' => 'activities/activity#weekly_behavior_data', :as => :weekly_activity_behavior_data, :via => :get


  #badges namespace
  match 'badges' => 'badges/badge#index', :as => :badges_list, :via => :get
  match 'badges/create' => 'badges/badge#create', :as => :badge_create, :via => :get
  match 'badges/new' => 'badges/badge#new', :as => :badge_new, :via => :post
  match 'badge/edit/:id' => 'badges/badge#edit', :as => :badge_edit, :via => :get
  match 'badge/update/:id' => 'badges/badge#update', :as => :badge_update, :via => :post
  match 'badge/delete/:id' => 'badges/badge#delete', :as => :badge_delete, :via => :get
  match 'badge/destroy/:id' => 'badges/badge#destroy', :as => :badge_destroy, :via => :get

  #events namespace
  match 'events' => 'events/event#index', :as => :events_list, :via => :get
  match 'events/create' => 'events/event#create', :as => :event_create, :via => :get
  match 'events/new' => 'events/event#new', :as => :event_new, :via => :post
  match 'event/show/:id' => 'events/event#show', :as => :event_show, :via => :get
  match 'event/edit/:id' => 'events/event#edit', :as => :event_edit, :via => :get
  match 'event/update/:id' => 'events/event#update', :as => :event_update, :via => :post
  match 'event/delete/:id' => 'events/event#delete', :as => :event_delete, :via => :get
  match 'event/destroy/:id' => 'events/event#destroy', :as => :event_destroy, :via => :get
  match 'event-behavior/:id' => 'events/event#behavior_data', :as => :event_behavior_data, :via => :get
  match 'weekly-event-behavior/(:id)' => 'events/event#weekly_behavior_data', :as => :weekly_event_behavior_data, :via => :get

  #subjects namespace
  match 'subjects' => 'subjects/subject#index', :as => :subjects_list, :via => :get
  match 'subjects/create' => 'subjects/subject#create', :as => :subject_create, :via => :get
  match 'subjects/new' => 'subjects/subject#new', :as => :subject_new, :via => :post
  match 'subject/show/:id' => 'subjects/subject#show', :as => :subject_show, :via => :get
  match 'subject/edit/:id' => 'subjects/subject#edit', :as => :subject_edit, :via => :get
  match 'subject/update/:id' => 'subjects/subject#update', :as => :subject_update, :via => :post
  match 'subject/delete/:id' => 'subjects/subject#delete', :as => :subject_delete, :via => :get
  match 'subject/destroy/:id' => 'subjects/subject#destroy', :as => :subject_destroy, :via => :get

  #API V1
  match "api/v1/apps" => "api/v1/apps#index", :as => :api_v1_apps_list, :via => :get
  match "api/v1/apps/:id" => "api/v1/apps#show", :as => :api_v1_app_detail, :via => :get
  #activities
  match "api/v1/activities/:id" => "api/v1/activity/activity#show", :as => :api_v1_activity_detail, :via => :get
  #app activities
  match "api/v1/app_activities/:id" => "api/v1/app_activities#index", :as => :api_v1_app_activities, :via => :get
  #activity related events
  match "api/v1/activity_events/:id" => "api/v1/activity/activity_events#index", :as => :api_v1_activity_events, :via => :get
  #activity log
  match "api/v1/activity_logs/:id(/:page)(/:limit)" => "api/v1/activity/activity_log#index", :as => :api_v1_activity_log, :via => :get
  #events
  match "api/v1/events/:id" => "api/v1/event/event#show", :as => :api_v1_event_detail, :via => :get
  #badge
  match "api/v1/badges/:id" => "api/v1/badge/badge#show", :as => :api_v1_badge_detail, :via => :get
  #subjects
  match "api/v1/users/:id" => "api/v1/subject/subject#show", :as => :api_v1_subject_detail, :via => :get
  match "api/v1/users" => "api/v1/subject/subject#new", :as => :api_v1_subject_create, :via => :post

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
