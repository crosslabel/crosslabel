Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
  resources :products do
    post '/vote' => 'upvotes#create'
    delete '/vote' => 'upvotes#destroy'
  end

  resources :categories, param: :title


  get '/explore' => 'home#explore', as: 'explore'

  get '/trending' => 'home#trending', as: 'trending'


  resources :shops

  resources :users, param: :username
  post '/:username/upload_avatar' => 'users#upload_avatar', :as => :upload_avatar
  post '/:username/remove_avatar' => 'users#remove_avatar', as: 'remove_avatar'
  post '/:username/set_facebook_photo' => 'users#set_default_facebook_photo', as: 'set_default_facebook_photo'


  #
  # namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
  #   scope :module => :v1, constraints: ApiConstraints.new(version: 1, default: true) do
  #     resources :users, :only => [:create, :update, :destroy]
  #     resources :sessions, :only => [:create, :destroy]
  #     resources :products
  #   end
  # end

  root 'home#index'
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
