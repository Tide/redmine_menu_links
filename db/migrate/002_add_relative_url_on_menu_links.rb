class AddRelativeUrlOnMenuLinks < ActiveRecord::Migration
  def self.up
    add_column(:menu_links, "relative_url", :boolean, :default => true, :null => false)
  end
  
  def self.down
    remove_column(:menu_links, "relative_url")
  end
end
