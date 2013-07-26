class RedmineMenuLinksHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    stylesheet_link_tag('redmine_menu_links.css', :plugin => 'redmine_menu_links')
  end
end

