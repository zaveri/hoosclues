ActionController::Routing::Routes.draw do |map|
  map.resources :contests

  map.resources :pictures, :has_many => :comments
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :has_many => :pictures
  map.resources :pictures, :member => { :rank_up => :put, :rank_down => :put}

  map.resource :session
  
  # Home Page
  map.root :controller => 'pictures'
  
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
