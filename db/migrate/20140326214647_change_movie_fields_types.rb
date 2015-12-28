# frozen_string_literal: true
class ChangeMovieFieldsTypes < ActiveRecord::Migration
  def change
    change_column :movies, :budget, :integer
    change_column :movies, :revenue, :integer
    change_column :movies, :runtime, :integer
    change_column :movies, :vote_average, :float
    change_column :movies, :vote_count, :integer
  end
end
