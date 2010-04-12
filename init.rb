require 'redmine'

RAILS_DEFAULT_LOGGER.info 'Menu Links plugin 0.0.1 for Redmine'

Redmine::Plugin.register :redmine_menu_links do
  name 'Menu Links Plugin'
  author 'Tide, Yuki Kita'
  description 'A plugin which adds links to the top menu of Redmine.'
  url         'http://github.com/Tide/redmine_menu_links'
  version '0.0.1'
    
  menu :admin_menu, :menu_links, { :controller => 'menu_links', :action => 'index'}, :caption => :label_menu_links
end

MenuLink.show
