CcmvSermonArchive::Application.routes.draw do
  get "sermons/index"

  # Root Page
  root to: 'sermons#main'

  match '/sermons', to: 'sermons#index', as: 'sermons'
  match '/service/:service', to: 'sermons#index', as: 'service'
  match '/speaker/:speaker', to: 'sermons#index', as: 'speaker'
  match '/book/:book', to: 'sermons#index', as: 'book'
  match '/passage/:passage', to: 'sermons#index', as: 'passage'
  match '/sermons/:id', to: 'sermons#show', as: 'sermon'
  # TODO Figure this out and ensure consistency across all

  scope '/tfth', defaults: { tfth: "true" } do
    root to: 'sermons#main', as: 'tfth_root'
    match '/sermons/:id', to: 'sermons#show', as: 'tfth_sermon'
    match '/sermons', to: 'sermons#index', as: 'tfth_sermons'
  end

  namespace :admin do
    match '/' => 'sermons#main', as: :root
    resources :sermons, :speakers, :services, :roles, :users,
      :except => [:show]
    get 'sermons/rescan_files'
  end

  # Admin needs to go above this or else we'll match here for /admin
  #match '/:page' => 'main#index', as: :root

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
