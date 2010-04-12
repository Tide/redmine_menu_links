class MenuLink < ActiveRecord::Base
  acts_as_list

  validates_presence_of :name, :url
  validates_length_of :name, :maximum => 60
  validates_length_of :url, :maximum => 255

  def to_s
    name
  end
  
  def <=>(link)
    position <=> link.position
  end

  def to_sym
    "menu_link_#{self.id}".to_sym
  end

  def self.each_enabled_link
    self.all.select(&:is_enabled).sort_by(&:position).each do |menu_link|
      yield menu_link
    end
  end

  def self.clean
    MenuLink.each_enabled_link do |menu_link|
      Redmine::MenuManager.map(:top_menu).delete(menu_link.to_sym)
    end
  end

  def self.show
    MenuLink.each_enabled_link do |menu_link|
      if menu_link.new_window
        case menu_link.link_type
        when 0
          Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, :caption=>menu_link.name, :html => { :target => '_blank' }, :before => :projects)
        when 1
          Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, :caption=>menu_link.name, :html => { :target => '_blank' }, :before => :projects , :if =>  Proc.new { User.current.logged? })
        when 2
          Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, :caption=>menu_link.name, :html => { :target => '_blank' }, :before => :projects , :if => Proc.new { User.current.admin? })
        end
      else
        case menu_link.link_type
        when 0
          Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, :caption=>menu_link.name, :before => :projects)
        when 1
          Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, :caption=>menu_link.name, :before => :projects , :if =>  Proc.new { User.current.logged? })
        when 2
          Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, :caption=>menu_link.name, :before => :projects , :if => Proc.new { User.current.admin? })
        end
      end
    end
  end
end
