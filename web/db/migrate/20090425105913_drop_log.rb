class DropLog < ActiveRecord::Migration
  def self.up
    drop_table :logs
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
