class DropStoresTable < ActiveRecord::Migration
  def change
    drop_table :stores
  end
end
