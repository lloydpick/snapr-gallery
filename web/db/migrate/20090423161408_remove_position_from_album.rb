class RemovePositionFromAlbum < ActiveRecord::Migration
  def self.up
    remove_column :albums, :position
  end

  def self.down
    add_column :albums, :position, :integer
  end
end
