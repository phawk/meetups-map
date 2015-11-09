class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name
      t.string :urlname
      t.string :category
      t.string :who
      t.integer :meetup_id
      t.string :city
      t.string :country
      t.string :link
      t.decimal :rating
      t.string :photo
      t.string :organizer_name
      t.integer :members_count
      t.st_point :coords, geographic: true

      t.timestamps null: false
    end

    add_index :meetups, :coords, using: :gist
  end
end
