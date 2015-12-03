# frozen_string_literal: true
class RemoveWatchesFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :watches
  end
end
