class MenuLink < ActiveRecord::Base
  acts_as_list

  validates_presence_of :name, :url
  validates_length_of :name, :maximum => 60
  validates_length_of :url, :maximum => 255
  validates_format_of :url, :with => URI.regexp(['http', 'https'])

  EVERYONE = 0
  USERS_ONLY = 1
  ADMINISTRATORS_ONLY = 2

  def to_s
    name
  end
  
  def <=>(link)
    position <=> link.position
  end

  def to_sym
    "menu_link_#{self.id}".to_sym
  end

  def for_everyone?
    link_type == EVERYONE
  end

  def for_users_only?
    link_type == USERS_ONLY
  end

  def for_administrators_only?
    link_type == ADMINISTRATORS_ONLY
  end

  def self.each_enabled_link
    self.all.select(&:is_enabled).sort_by(&:position).each do |menu_link|
      yield menu_link
    end
  end

  def self.clean
    self.each_enabled_link do |menu_link|
      Redmine::MenuManager.map(:top_menu).delete(menu_link.to_sym)
    end
  end

  def self.show
    self.each_enabled_link do |menu_link|
      option = {:caption=>menu_link.name, :before => :projects}
      option[:html] = {:target => '_blank'} if menu_link.new_window
      option[:if] = menu_link.for_users_only? ? Proc.new {User.current.logged?} : (menu_link.for_administrators_only? ? Proc.new {User.current.admin?} : nil)
      Redmine::MenuManager.map(:top_menu).push(menu_link.to_sym, menu_link.url, option)
    end
  end
end
