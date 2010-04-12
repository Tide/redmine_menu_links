class CreateMenuLinks < ActiveRecord::Migration
  def self.up
    create_table :menu_links do |t|
      t.column "name", :string, :limit => 60, :null => false
      t.column "url", :string, :limit => 255, :null => false
      t.column "is_enabled", :boolean, :default => false, :null => false
      t.column "new_window", :boolean, :default => false, :null => false
      t.column "link_type", :integer, :default => 0
      t.column "position", :integer, :default => 1
    end
  end
  
  def self.down
    drop_table :menu_links
  end
end
