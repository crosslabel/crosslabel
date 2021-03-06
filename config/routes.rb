Rails.application.routes.draw do
  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

  root 'home#index'


  devise_for :users, :skip => [:sessions, :registrations], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :passwords => "users/passwords" }
  as :user do
    get 'signup' => 'users/registrations#new', :as => :new_user_registration
    post 'signup' => 'users/registrations#create', :as => :user_registration
    get 'signin' => 'users/sessions#new', :as => :new_user_session
    post 'signin' => 'users/sessions#create', :as => :user_session
    delete 'signout' => 'users/sessions#destroy', :as => :destroy_user_session
  end

  resources :after_omniauth

  resources :retailers, param: :name, except: :show do
    resources :products
  end
  get '/retailers/:name(/page/:page)' => 'retailers#show', :page => 1


  resources :products do
    post '/vote' => 'upvotes#create'
    delete '/vote' => 'upvotes#destroy'
    collection do
      get :autocomplete
    end
  end

  get '/categories' => 'categories#index', as: :categories
  get '/categories/:name(/page/:page)' => 'categories#show', as: :category, :page => 1
  get '/explore(/page/:page)' => 'home#explore', as: 'explore', :page => 1

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all


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
