class AdminMenuHooks < Redmine::Hook::ViewListener
  
  def view_layouts_base_html_head(context = { })
    o = <<CSS
  <style type="text/css">

.icon-menu-links { background-image: url(../plugin_assets/redmine_menu_links/images/menu-links.png); }

  </style>
CSS
    return o
  end
end

