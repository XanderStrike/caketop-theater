class AddFieldsToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :url, :text
    add_column :artists, :image, :text
    add_column :artists, :bio, :text
    add_column :artists, :year, :text
    add_column :artists, :home, :text
  end
end
