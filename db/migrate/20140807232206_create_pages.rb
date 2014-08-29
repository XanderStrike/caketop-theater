class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :text
      t.text :content
      t.string :name
      t.boolean :navbar
      t.boolean :footer
      t.timestamps
    end
    add_index :pages, :name, unique: true
  end
end
