class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :artist
      t.string :name
      t.string :art
      t.string :year
      t.string :genre
      t.timestamps
    end
  end
end
