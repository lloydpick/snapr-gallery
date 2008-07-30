ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
  
  map.connect '', :controller => 'home', :action => 'home'
  
  map.connect 'signin', :controller => 'users', :action => 'login'
  map.connect 'signout', :controller => 'users', :action => 'logout'
  map.connect 'login', :controller => 'users', :action => 'login'
  map.connect 'logout', :controller => 'users', :action => 'logout'
  
  map.connect 'album', :controller => 'albums', :action => 'list'
  map.connect 'album/new', :controller => 'albums', :action => 'new'
  map.connect 'album/:permalink', :controller => 'albums', :action => 'show'
  map.connect 'album/:permalink/upload', :controller => 'images', :action => 'new'
  map.connect 'album/:permalink/swfupload/:id', :controller => 'images', :action => 'swfupload'
  map.connect 'album/:permalink/upload/process', :controller => 'images', :action => 'create'
  map.connect 'album/:permalink/:photolink', :controller => 'photos', :action => 'show'
  map.connect 'album/:permalink/:photolink/full', :controller => 'photos', :action => 'show_full'
  map.connect 'album/:permalink/:photolink/location', :controller => 'photos', :action => 'location'

  map.connect 'geotag', :controller => 'geotag', :action => 'list'
  map.connect 'geotag/new', :controller => 'geotag', :action => 'new'

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
