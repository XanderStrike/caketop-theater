# frozen_string_literal: true
class AddWatchesToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :watches, :integer, default: 0
  end
end
