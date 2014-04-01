class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :content
      t.string :path
      t.string :ip

      t.timestamps
    end
  end
end
