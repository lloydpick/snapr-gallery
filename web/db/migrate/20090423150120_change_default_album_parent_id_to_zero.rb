class ChangeDefaultAlbumParentIdToZero < ActiveRecord::Migration
  def self.up
    change_column_default(:albums, :parent_id, 0)
    Album.find(:all, :conditions => "parent_id IS NULL").each do |album|
      album.parent_id = 0
      album.save!
    end
  end

  def self.down
    change_column_default(:albums, :parent_id, nil)
    Album.find(:all, :conditions => "parent_id IS NULL").each do |album|
      album.parent_id = nil
      album.save!
    end
  end
end
