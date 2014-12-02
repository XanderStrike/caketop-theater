class RemoveFilenameFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :filename
  end
end
