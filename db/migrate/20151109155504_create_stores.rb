class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.text :street_address
      t.st_point :lonlat, geographic: true

      t.timestamps null: false
    end

    add_index :stores, :lonlat, using: :gist
  end
end
