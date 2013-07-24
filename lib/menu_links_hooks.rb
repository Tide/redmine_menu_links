class MenuLinksHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    stylesheet_link_tag('menu_links.css', :plugin => 'menu_links')
  end
end

