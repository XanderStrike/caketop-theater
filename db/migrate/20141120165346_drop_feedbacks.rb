class DropFeedbacks < ActiveRecord::Migration
  def change
    drop_table :feedbacks
  end
end
