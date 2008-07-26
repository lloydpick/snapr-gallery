class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column "album_id", :integer
      t.column "image_id", :integer
      t.column "path", :string
      t.column "title", :string
      t.column "caption", :string
      t.column "is_visible", :boolean, :default => true
      t.column "position", :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
