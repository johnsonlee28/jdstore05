class DropSubscriberTable < ActiveRecord::Migration[5.0]
  def change
  end

  def up
    drop_table :subscribers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
