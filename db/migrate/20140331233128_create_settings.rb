class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.column :id, :string

      t.string :content
      t.column :number, :integer
      t.column :boolean, :boolean

      t.timestamps
    end
  end
end
