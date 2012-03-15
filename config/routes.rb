CcmvSermonArchive::Application.routes.draw do
  get "sermons/index"

  # Root Page
  root to: 'sermons#main'

  match '/sermons', to: 'sermons#index', as: 'sermons'
  match '/sermon/:id', to: 'sermons#show', as: 'sermon'

  # Routes with single filter
  match '/service/:service', to: 'sermons#index', as: 'service'
  match '/speaker/:speaker', to: 'sermons#index', as: 'speaker'
  match '/book/:book', to: 'sermons#book_index', as: 'book'
  match '/passage/:passage', to: 'sermons#passage_index', as: 'passage'

  # Routes with page
  match '/sermons/:page', to: 'sermons#index', as: 'sermons_page'
  match '/service/:service/:page', to: 'sermons#index', as: 'service_page'
  match '/speaker/:speaker/:page', to: 'sermons#index', as: 'speaker_page'
  match '/book/:book/:page', to: 'sermons#book_index', as: 'book_page'
  match '/passage/:passage/:page', to: 'sermons#passage_index', as: 'passage_page'

  # Routes with page and sort
  match '/sermons/:page/sort/:sort', to: 'sermons#index',
    as: 'sermons_page_sort'
  match '/service/:service/:page/sort/:sort', to: 'sermons#index', 
    as: 'service_page_sort'
  match '/speaker/:speaker/:page/sort/:sort', to: 'sermons#index',
    as: 'speaker_page_sort'
  match '/book/:book/:page/sort/:sort', to: 'sermons#book_index',
    as: 'book_page_sort'
  match '/passage/:passage/:page/sort/:sort', to: 'sermons#passage_index',
    as: 'passage_page_sort'

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
