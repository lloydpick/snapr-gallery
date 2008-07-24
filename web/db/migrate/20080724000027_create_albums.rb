class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.column "parent_album_id", :integer
      t.column "title", :string
      t.column "description", :string
      t.column "position", :integer
      t.column "is_visible", :boolean, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
