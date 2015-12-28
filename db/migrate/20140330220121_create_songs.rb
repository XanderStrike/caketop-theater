# frozen_string_literal: true
class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.belongs_to :album
      t.string :title
      t.string :filename
      t.integer :track

      t.timestamps
    end
  end
end
