Abibook::Application.routes.draw do

  get '/steckbrief' => 'profile#edit', :as => :edit_profile
  put '/steckbrief' => 'profile#update'

  resources :quotes, :path => '/zitate', :path_names => { :new => 'neues-zitat', :edit => 'bearbeiten' }, :except => [:show]
  resources :comments, :path => '/kommentare', :path_names => { :new => 'neuer-kommentar', :edit => 'bearbeiten' }, :except => [:show]

  resources :votings, :path => '/votings', :except => [:new, :create, :edit, :destroy]

  get '/admin/freischalten' => 'admin/activation#index', :as => :activations
  get '/admin/freischalten/:id' => 'admin/activation#edit', :as => :edit_activations
  put '/admin/freischalten/:id' => 'admin/activation#update'

  devise_for :users, :skip => [:registrations, :passwords, :sessions]
  as :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    post '/pw-vergessen' => 'devise/passwords#create', :as => :user_password
    get '/pw-vergessen' => 'devise/passwords#new'
    get '/pw-vergessen/neues-pw' => 'devise/passwords#edit', :as => :edit_user_password
    put '/pw-vergessen/neues-pw' => 'devise/passwords#update'
    post '/registrierung' => 'devise/registrations#create', :as => :user_registration
    get '/registrierung' => 'devise/registrations#new', :as => :new_user_registration
    root :to => 'dashboard#index'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
