class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :name
      t.string :desc
      t.string :link
      t.string :ip
      t.string :id

      t.timestamps
    end
  end
end
