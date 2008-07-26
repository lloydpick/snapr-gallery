class AddPermalinkToAlbum < ActiveRecord::Migration
  def self.up
    add_column(:albums, :permalink, :string, :limit => 200)
  end

  def self.down
    remove_column(:albums, :permalink)
  end
end
