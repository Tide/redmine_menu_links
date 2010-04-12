class AdminMenuHooks < Redmine::Hook::ViewListener
  
  # Add a question CSS class
  def view_layouts_base_html_head(context = { })
    o = <<CSS
  <style type="text/css">

.icon {
background-position: 0% 50%;
background-repeat: no-repeat;
padding-left: 20px;
padding-top: 2px;
padding-bottom: 3px;
}

.icon-menu-links { background-image: url(../plugin_assets/redmine_menu_links/images/menu-links.png); }

  </style>
CSS
    return o
  end
end

