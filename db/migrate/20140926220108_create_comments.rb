class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :body
      t.string :movie_id

      t.timestamps
    end
  end
end
