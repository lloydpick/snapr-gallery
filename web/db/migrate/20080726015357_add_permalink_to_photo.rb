class AddPermalinkToPhoto < ActiveRecord::Migration
  def self.up
    add_column(:photos, :permalink, :string, :limit => 200)
  end

  def self.down
    remove_column(:photos, :permalink)
  end
end
