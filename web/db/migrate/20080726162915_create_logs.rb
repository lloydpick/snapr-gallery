class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.column :user_id, :integer
      t.column :item, :string
      t.column :event, :string
      t.column :identifier, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
