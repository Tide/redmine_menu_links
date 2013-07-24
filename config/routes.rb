RedmineApp::Application.routes.draw do
  match 'menu_links/index', :controller => 'menu_links', :action => 'index', :via => [:get, :post]
  match 'menu_links/new', :controller => 'menu_links', :action => 'new', :via => [:get, :post]
  match 'menu_links/create', :controller => 'menu_links', :action => 'create', :via => [:get, :post]
  match 'menu_links/edit', :controller => 'menu_links', :action => 'edit', :via => [:get, :post]
  match 'menu_links/update', :controller => 'menu_links', :action => 'update', :via => [:put, :post]
  match 'menu_links/destroy', :controller => 'menu_links', :action => 'destroy', :via => [:get, :post]
end