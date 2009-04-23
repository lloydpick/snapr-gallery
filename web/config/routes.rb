ActionController::Routing::Routes.draw do |map|

  # Public Routes
  map.root :controller => "home", :action => "index"

  map.connect 'signin', :controller => 'users', :action => 'login'
  map.connect 'signout', :controller => 'users', :action => 'logout'
  map.connect 'login', :controller => 'users', :action => 'login'
  map.connect 'logout', :controller => 'users', :action => 'logout'

  map.resources :geotags
  map.resources :albums do |album|
    album.resources :photos, :has_one => :geotag
  end

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
end
