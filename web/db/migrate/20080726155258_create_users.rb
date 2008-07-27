class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :username, :string
      t.column :emailaddress, :string
      t.column :password, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
