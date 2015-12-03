# frozen_string_literal: true
class AddFilenameToEncode < ActiveRecord::Migration
  def change
    add_column :encodes, :filename, :text
  end
end
