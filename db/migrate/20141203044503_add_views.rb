class AddViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :movie_id

      t.timestamps
    end
  end
end
