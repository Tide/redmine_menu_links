require 'redmine'
require 'redmine_menu_links_hooks'

Rails.logger.info 'Starting Menu Links Plugin for Redmine'

Redmine::Plugin.register :redmine_menu_links do
  name 'Menu Links Plugin'
  author 'Tide, Yuki Kita'
  description 'A plugin which adds links to the top menu of Redmine.'
  url         'http://github.com/Tide/redmine_menu_links' if respond_to?(:url)
  version '0.0.1'
    
  menu :admin_menu, :redmine_menu_links, { :controller => 'menu_links', :action => 'index'}, :caption => :label_menu_links
end

MenuLink.show if MenuLink.table_exists?
