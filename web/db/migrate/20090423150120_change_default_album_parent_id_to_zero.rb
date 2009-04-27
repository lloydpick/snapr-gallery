class ChangeDefaultAlbumParentIdToZero < ActiveRecord::Migration
  def self.up
    change_column_default(:albums, :parent_id, 0)
  end

  def self.down
    change_column_default(:albums, :parent_id, nil)
  end
end
