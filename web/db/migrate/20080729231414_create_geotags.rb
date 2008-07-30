class CreateGeotags < ActiveRecord::Migration
  def self.up
    create_table :geotags do |t|
      t.column "latitude", :float
      t.column "longitude", :float
      t.column "zoom", :integer
      t.column "description", :string
      t.timestamps
    end
    add_column :photos, :geotag_id, :integer
  end

  def self.down
    drop_table :geotags
    remove_column :photos, :geotag_id
  end
end
